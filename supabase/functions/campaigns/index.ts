import { authenticate, requireRole, type AuthContext } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";

// campaigns function
//   GET    /campaigns                 -> open feed (filters: category,type,q,min_followers) + bookmarked flag
//   GET    /campaigns?scope=mine      -> company's own campaigns (any status)
//   GET    /campaigns?scope=bookmarked-> the caller's bookmarked campaigns
//   GET    /campaigns?scope=popular   -> open campaigns ranked by applicant_count
//   GET    /campaigns/:id             -> detail + company + images + bookmarked
//   POST   /campaigns                 -> create (company)
//   PATCH  /campaigns/:id             -> update (owner)
//   DELETE /campaigns/:id             -> delete (owner)
//   POST   /campaigns/:id/bookmark    -> toggle bookmark -> { bookmarked }
//   POST   /campaigns/:id/publish     -> status open (owner)
//   POST   /campaigns/:id/close       -> status closed (owner)
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const ctx = await authenticate(req);
    const url = new URL(req.url);
    const segs = url.pathname.split("/").filter(Boolean);
    const i = segs.indexOf("campaigns");
    const id = i >= 0 ? segs[i + 1] : undefined;
    const action = i >= 0 ? segs[i + 2] : undefined;
    const select = "*, company:companies(company_name, verified)";

    // LIST
    if (req.method === "GET" && !id) {
      const p = url.searchParams;
      const scope = p.get("scope");

      if (scope === "mine") {
        requireRole(ctx, "company");
        let q = ctx.admin.from("campaigns").select(select)
          .eq("company_id", ctx.userId)
          .order("created_at", { ascending: false });
        const status = p.get("status");
        if (status) q = q.eq("status", status);
        const { data, error } = await q;
        if (error) throw new HttpError(400, error.message);
        return ok({ campaigns: await withBookmarks(ctx, data ?? []) });
      }

      if (scope === "bookmarked") {
        const { data: marks } = await ctx.admin.from("campaign_bookmarks")
          .select("campaign_id")
          .eq("profile_id", ctx.userId)
          .order("created_at", { ascending: false });
        const ids = (marks ?? []).map((m) => m.campaign_id);
        if (ids.length === 0) return ok({ campaigns: [] });
        const { data, error } = await ctx.admin.from("campaigns")
          .select(select).in("id", ids);
        if (error) throw new HttpError(400, error.message);
        const order = new Map(ids.map((cid, idx) => [cid, idx]));
        const sorted = (data ?? []).sort(
          (a, b) => (order.get(a.id) ?? 0) - (order.get(b.id) ?? 0),
        );
        return ok({ campaigns: sorted.map((c) => ({ ...c, bookmarked: true })) });
      }

      if (scope === "popular") {
        const { data: open, error } = await ctx.admin.from("campaigns")
          .select(select).eq("status", "open");
        if (error) throw new HttpError(400, error.message);
        const counts = await applicantCounts(ctx, (open ?? []).map((c) => c.id));
        const ranked = (open ?? [])
          .map((c) => ({ ...c, applicant_count: counts.get(c.id) ?? 0 }))
          .sort((a, b) =>
            b.applicant_count - a.applicant_count ||
            new Date(b.created_at).getTime() - new Date(a.created_at).getTime()
          )
          .slice(0, 50);
        return ok({ campaigns: await withBookmarks(ctx, ranked) });
      }

      // default: open feed + filters
      let q = ctx.admin.from("campaigns").select(select)
        .eq("status", "open")
        .order("created_at", { ascending: false });
      const category = p.get("category");
      const type = p.get("type");
      const search = p.get("q");
      const minF = p.get("min_followers");
      if (category) q = q.eq("category", category);
      if (type) q = q.eq("type", type);
      if (search) q = q.ilike("title", `%${search}%`);
      if (minF) q = q.lte("min_followers", Number(minF));
      const { data, error } = await q;
      if (error) throw new HttpError(400, error.message);
      return ok({ campaigns: await withBookmarks(ctx, data ?? []) });
    }

    // DETAIL
    if (req.method === "GET" && id && !action) {
      const { data, error } = await ctx.admin.from("campaigns")
        .select(select).eq("id", id).maybeSingle();
      if (error) throw new HttpError(400, error.message);
      if (!data) throw new HttpError(404, "campaign_not_found");
      const { data: mark } = await ctx.admin.from("campaign_bookmarks")
        .select("campaign_id")
        .eq("profile_id", ctx.userId).eq("campaign_id", id).maybeSingle();
      // Has the caller already applied? (drives apply vs cancel button)
      const { data: myApp } = await ctx.admin.from("applications")
        .select("id, status")
        .eq("campaign_id", id).eq("influencer_id", ctx.userId).maybeSingle();
      const { data: images } = await ctx.admin.from("campaign_images")
        .select("*").eq("campaign_id", id).order("sort");
      return ok({
        campaign: {
          ...data,
          bookmarked: !!mark,
          applied: !!myApp,
          application_id: myApp?.id ?? null,
          application_status: myApp?.status ?? null,
        },
        images: images ?? [],
      });
    }

    // CREATE
    if (req.method === "POST" && !id) {
      requireRole(ctx, "company");
      const body = await req.json().catch(() => ({}));
      if (!body.title) throw new HttpError(400, "title_required");
      const insert = {
        company_id: ctx.userId,
        title: body.title,
        description: body.description ?? null,
        category: body.category ?? null,
        type: body.type ?? "delivery",
        reward_type: body.reward_type ?? null,
        reward_amount: body.reward_amount ?? null,
        recruit_count: body.recruit_count ?? 1,
        requirements: body.requirements ?? {},
        content_guide: body.content_guide ?? null,
        min_followers: body.min_followers ?? 0,
        thumbnail_url: body.thumbnail_url ?? null,
        apply_deadline: body.apply_deadline ?? null,
        start_at: body.start_at ?? null,
        end_at: body.end_at ?? null,
        status: body.status === "open" ? "open" : "draft",
      };
      const { data, error } = await ctx.admin.from("campaigns")
        .insert(insert).select(select).single();
      if (error) throw new HttpError(400, error.message);
      if (Array.isArray(body.images) && body.images.length) {
        const rows = (body.images as string[]).map((u, idx) => ({
          campaign_id: data.id,
          url: u,
          sort: idx,
        }));
        await ctx.admin.from("campaign_images").insert(rows);
      }
      return ok({ campaign: data });
    }

    // BOOKMARK toggle (any authenticated user)
    if (req.method === "POST" && id && action === "bookmark") {
      const { data: existing } = await ctx.admin.from("campaign_bookmarks")
        .select("campaign_id")
        .eq("profile_id", ctx.userId).eq("campaign_id", id).maybeSingle();
      let bookmarked: boolean;
      if (existing) {
        await ctx.admin.from("campaign_bookmarks").delete()
          .eq("profile_id", ctx.userId).eq("campaign_id", id);
        bookmarked = false;
      } else {
        const { error } = await ctx.admin.from("campaign_bookmarks")
          .insert({ profile_id: ctx.userId, campaign_id: id });
        if (error && error.code !== "23505") throw new HttpError(400, error.message);
        bookmarked = true;
      }
      return ok({ bookmarked });
    }

    // mutations below require company ownership
    const assertOwner = async (cid: string) => {
      const { data } = await ctx.admin.from("campaigns")
        .select("company_id").eq("id", cid).maybeSingle();
      if (!data) throw new HttpError(404, "campaign_not_found");
      if (data.company_id !== ctx.userId) throw new HttpError(403, "not_owner");
    };

    // PUBLISH / CLOSE
    if (req.method === "POST" && id && (action === "publish" || action === "close")) {
      requireRole(ctx, "company");
      await assertOwner(id);
      const status = action === "publish" ? "open" : "closed";
      const { data, error } = await ctx.admin.from("campaigns")
        .update({ status }).eq("id", id).select(select).single();
      if (error) throw new HttpError(400, error.message);
      return ok({ campaign: data });
    }

    // UPDATE
    if (req.method === "PATCH" && id) {
      requireRole(ctx, "company");
      await assertOwner(id);
      const body = await req.json().catch(() => ({}));
      const patch: Record<string, unknown> = {};
      const fields = [
        "title", "description", "category", "type", "reward_type",
        "reward_amount", "recruit_count", "requirements", "content_guide",
        "min_followers", "thumbnail_url", "apply_deadline", "start_at",
        "end_at", "status",
      ];
      for (const k of fields) if (k in body) patch[k] = body[k];
      const { data, error } = await ctx.admin.from("campaigns")
        .update(patch).eq("id", id).select(select).single();
      if (error) throw new HttpError(400, error.message);
      return ok({ campaign: data });
    }

    // DELETE
    if (req.method === "DELETE" && id) {
      requireRole(ctx, "company");
      await assertOwner(id);
      const { error } = await ctx.admin.from("campaigns").delete().eq("id", id);
      if (error) throw new HttpError(400, error.message);
      return ok({ deleted: true });
    }

    throw new HttpError(404, "not_found");
  } catch (err) {
    return fail(err);
  }
});

// Annotate campaign rows with the caller's bookmark state in one query.
async function withBookmarks(
  ctx: AuthContext,
  // deno-lint-ignore no-explicit-any
  rows: any[],
  // deno-lint-ignore no-explicit-any
): Promise<any[]> {
  if (rows.length === 0) return rows;
  const { data } = await ctx.admin.from("campaign_bookmarks")
    .select("campaign_id")
    .eq("profile_id", ctx.userId)
    .in("campaign_id", rows.map((r) => r.id));
  const set = new Set((data ?? []).map((m) => m.campaign_id));
  return rows.map((r) => ({ ...r, bookmarked: set.has(r.id) }));
}

// Applicant counts per campaign id (for the popular ranking).
async function applicantCounts(
  ctx: AuthContext,
  ids: string[],
): Promise<Map<string, number>> {
  const map = new Map<string, number>();
  if (ids.length === 0) return map;
  const { data } = await ctx.admin.from("applications")
    .select("campaign_id").in("campaign_id", ids);
  for (const a of data ?? []) {
    map.set(a.campaign_id, (map.get(a.campaign_id) ?? 0) + 1);
  }
  return map;
}
