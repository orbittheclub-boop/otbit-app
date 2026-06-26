import { authenticate } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";

// reviews function
//   POST /reviews                    -> rate the counterpart on an application
//   GET  /reviews?application_id=:id -> reviews for an application
//   GET  /reviews?campaign_id=:id    -> reviews for a campaign
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const ctx = await authenticate(req);
    const url = new URL(req.url);

    if (req.method === "POST") {
      const body = await req.json().catch(() => ({}));
      if (!body.application_id || !body.rating) {
        throw new HttpError(400, "application_id_and_rating_required");
      }
      const { data: app } = await ctx.admin.from("applications")
        .select("id, campaign_id, influencer_id, campaign:campaigns(company_id)")
        .eq("id", body.application_id).maybeSingle();
      if (!app) throw new HttpError(404, "application_not_found");

      let fromRole: "company" | "influencer";
      if (ctx.role === "company" && app.campaign?.company_id === ctx.userId) {
        fromRole = "company";
      } else if (ctx.role === "influencer" && app.influencer_id === ctx.userId) {
        fromRole = "influencer";
      } else {
        throw new HttpError(403, "not_related");
      }

      const rating = Math.max(1, Math.min(5, Math.round(Number(body.rating))));
      const { data, error } = await ctx.admin.from("reviews").insert({
        campaign_id: app.campaign_id,
        application_id: app.id,
        from_role: fromRole,
        rating,
        comment: body.comment ?? null,
      }).select("*").single();
      if (error) throw new HttpError(400, error.message);
      return ok({ review: data });
    }

    if (req.method === "GET") {
      const applicationId = url.searchParams.get("application_id");
      const campaignId = url.searchParams.get("campaign_id");
      let q = ctx.admin.from("reviews").select("*")
        .order("created_at", { ascending: false });
      if (applicationId) q = q.eq("application_id", applicationId);
      else if (campaignId) q = q.eq("campaign_id", campaignId);
      else throw new HttpError(400, "filter_required");
      const { data, error } = await q;
      if (error) throw new HttpError(400, error.message);
      return ok({ reviews: data ?? [] });
    }

    throw new HttpError(404, "not_found");
  } catch (err) {
    return fail(err);
  }
});
