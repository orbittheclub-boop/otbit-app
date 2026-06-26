import { authenticate, requireRole } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";

const PLACEHOLDER = "00000000-0000-0000-0000-000000000000";

// settlements function
//   POST   /settlements                  -> create (company, owns campaign of app)
//   PATCH  /settlements/:id               -> update status (company)
//   GET    /settlements?scope=mine        -> influencer's settlements
//   GET    /settlements?campaign_id=:id   -> a campaign's settlements (owner)
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const ctx = await authenticate(req);
    const url = new URL(req.url);
    const segs = url.pathname.split("/").filter(Boolean);
    const i = segs.indexOf("settlements");
    const id = i >= 0 ? segs[i + 1] : undefined;

    const ownsCampaign = async (campaignId: string) => {
      const { data } = await ctx.admin.from("campaigns")
        .select("company_id").eq("id", campaignId).maybeSingle();
      if (!data) throw new HttpError(404, "campaign_not_found");
      if (data.company_id !== ctx.userId) throw new HttpError(403, "not_owner");
    };

    const ownsApp = async (applicationId: string) => {
      const { data } = await ctx.admin.from("applications")
        .select("campaign:campaigns(company_id)").eq("id", applicationId).maybeSingle();
      if (!data) throw new HttpError(404, "application_not_found");
      if (data.campaign?.company_id !== ctx.userId) throw new HttpError(403, "not_owner");
    };

    // CREATE
    if (req.method === "POST" && !id) {
      requireRole(ctx, "company");
      const body = await req.json().catch(() => ({}));
      if (!body.application_id) throw new HttpError(400, "application_id_required");
      await ownsApp(body.application_id);
      const paid = body.status === "paid";
      const { data, error } = await ctx.admin.from("settlements").insert({
        application_id: body.application_id,
        amount: body.amount ?? 0,
        method: body.method ?? null,
        status: paid ? "paid" : "pending",
        paid_at: paid ? new Date().toISOString() : null,
      }).select("*").single();
      if (error) throw new HttpError(400, error.message);
      return ok({ settlement: data });
    }

    // UPDATE status
    if (req.method === "PATCH" && id) {
      requireRole(ctx, "company");
      const { data: s } = await ctx.admin.from("settlements")
        .select("application_id").eq("id", id).maybeSingle();
      if (!s) throw new HttpError(404, "settlement_not_found");
      await ownsApp(s.application_id);
      const body = await req.json().catch(() => ({}));
      const status = body.status ?? "pending";
      const patch: Record<string, unknown> = { status };
      if (status === "paid") patch.paid_at = new Date().toISOString();
      const { data, error } = await ctx.admin.from("settlements")
        .update(patch).eq("id", id).select("*").single();
      if (error) throw new HttpError(400, error.message);
      return ok({ settlement: data });
    }

    // LIST
    if (req.method === "GET" && !id) {
      const campaignId = url.searchParams.get("campaign_id");
      if (campaignId) {
        requireRole(ctx, "company");
        await ownsCampaign(campaignId);
        const { data: apps } = await ctx.admin.from("applications")
          .select("id").eq("campaign_id", campaignId);
        const ids = (apps ?? []).map((a) => a.id);
        const { data, error } = await ctx.admin.from("settlements")
          .select("*, application:applications(influencer:influencers(nickname))")
          .in("application_id", ids.length ? ids : [PLACEHOLDER])
          .order("created_at", { ascending: false });
        if (error) throw new HttpError(400, error.message);
        return ok({ settlements: data ?? [] });
      }
      requireRole(ctx, "influencer");
      const { data: apps } = await ctx.admin.from("applications")
        .select("id").eq("influencer_id", ctx.userId);
      const ids = (apps ?? []).map((a) => a.id);
      const { data, error } = await ctx.admin.from("settlements")
        .select("*, application:applications(campaign:campaigns(title, company:companies(company_name)))")
        .in("application_id", ids.length ? ids : [PLACEHOLDER])
        .order("created_at", { ascending: false });
      if (error) throw new HttpError(400, error.message);
      return ok({ settlements: data ?? [] });
    }

    throw new HttpError(404, "not_found");
  } catch (err) {
    return fail(err);
  }
});
