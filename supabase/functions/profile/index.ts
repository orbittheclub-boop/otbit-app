import { authenticate } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";

// profile function
//   GET    /profile/me        -> current profile + role-specific row
//   POST   /profile/complete  -> onboarding: create profile + role row
//   PATCH  /profile           -> update editable profile fields
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const ctx = await authenticate(req);
    const path = new URL(req.url).pathname;

    // GET current profile (+ company/influencer detail)
    if (req.method === "GET" && (path.endsWith("/me") || path.endsWith("/profile"))) {
      const { data: profile } = await ctx.admin
        .from("profiles").select("*").eq("id", ctx.userId).maybeSingle();
      if (!profile) return ok({ profile: null });

      let extra: Record<string, unknown> = {};
      if (profile.role === "company") {
        const { data } = await ctx.admin
          .from("companies").select("*").eq("id", ctx.userId).maybeSingle();
        extra = { company: data };
      } else if (profile.role === "influencer") {
        const { data } = await ctx.admin
          .from("influencers").select("*").eq("id", ctx.userId).maybeSingle();
        extra = { influencer: data };
      }
      return ok({ profile, ...extra });
    }

    // POST onboarding: pick role and create base + role-specific rows
    if (req.method === "POST" && path.endsWith("/complete")) {
      const body = await req.json().catch(() => ({}));
      const role = body.role;
      if (role !== "company" && role !== "influencer") throw new HttpError(400, "invalid_role");

      const { data: profile, error } = await ctx.admin.from("profiles").upsert({
        id: ctx.userId,
        role,
        email: ctx.email,
        display_name: body.display_name ?? null,
        phone: body.phone ?? null,
        onboarded: true,
      }).select().single();
      if (error) throw new HttpError(400, error.message);

      if (role === "company") {
        const { error: e } = await ctx.admin.from("companies").upsert({
          id: ctx.userId,
          company_name: body.company_name ?? body.display_name ?? "",
          biz_no: body.biz_no ?? null,
          contact: body.contact ?? null,
          website: body.website ?? null,
        });
        if (e) throw new HttpError(400, e.message);
      } else {
        const { error: e } = await ctx.admin.from("influencers").upsert({
          id: ctx.userId,
          nickname: body.nickname ?? body.display_name ?? null,
          bio: body.bio ?? null,
          categories: body.categories ?? [],
          main_platform: body.main_platform ?? null,
        });
        if (e) throw new HttpError(400, e.message);
      }
      return ok({ profile });
    }

    // PATCH editable profile + role-specific fields (e.g. nickname).
    if (req.method === "PATCH") {
      const body = await req.json().catch(() => ({}));

      const pick = (keys: string[]) => {
        const o: Record<string, unknown> = {};
        for (const k of keys) if (k in body) o[k] = body[k];
        return o;
      };

      const patch = pick(["display_name", "avatar_url", "phone"]);
      if (Object.keys(patch).length) {
        const { error } = await ctx.admin
          .from("profiles").update(patch).eq("id", ctx.userId);
        if (error) throw new HttpError(400, error.message);
      }

      if (ctx.role === "influencer") {
        const inf = pick(["nickname", "bio", "main_platform"]);
        if (Object.keys(inf).length) {
          const { error } = await ctx.admin
            .from("influencers").update(inf).eq("id", ctx.userId);
          if (error) throw new HttpError(400, error.message);
        }
      } else if (ctx.role === "company") {
        const co = pick(["company_name", "biz_no", "contact", "website"]);
        if (Object.keys(co).length) {
          const { error } = await ctx.admin
            .from("companies").update(co).eq("id", ctx.userId);
          if (error) throw new HttpError(400, error.message);
        }
      }

      const { data: profile } = await ctx.admin
        .from("profiles").select("*").eq("id", ctx.userId).maybeSingle();
      return ok({ profile });
    }

    // DELETE account (App Store 5.1.1(v)): remove the auth user. Every related
    // row (profile, company/influencer, campaigns, applications, board posts,
    // bookmarks, device tokens, notifications…) is FK ON DELETE CASCADE, so
    // this wipes the user's data in one shot.
    if (req.method === "DELETE") {
      const { error } = await ctx.admin.auth.admin.deleteUser(ctx.userId);
      if (error) throw new HttpError(400, error.message);
      return ok({ deleted: true });
    }

    throw new HttpError(404, "not_found");
  } catch (err) {
    return fail(err);
  }
});
