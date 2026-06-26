import { authenticate, requireRole } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";

// applications function
//   POST   /applications                 -> apply (influencer)
//   GET    /applications?scope=mine       -> my applications (influencer)
//   GET    /applications?campaign_id=:id  -> applicants of a campaign (owner)
//   POST   /applications/:id/decide       -> accept/reject (campaign owner)
//   POST   /applications/:id/submit       -> submit content (influencer)
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const ctx = await authenticate(req);
    const url = new URL(req.url);
    const segs = url.pathname.split("/").filter(Boolean);
    const i = segs.indexOf("applications");
    const id = i >= 0 ? segs[i + 1] : undefined;
    const action = i >= 0 ? segs[i + 2] : undefined;

    const ownsCampaign = async (campaignId: string) => {
      const { data } = await ctx.admin.from("campaigns")
        .select("company_id").eq("id", campaignId).maybeSingle();
      if (!data) throw new HttpError(404, "campaign_not_found");
      if (data.company_id !== ctx.userId) throw new HttpError(403, "not_owner");
    };

    // APPLY
    if (req.method === "POST" && !id) {
      requireRole(ctx, "influencer");
      const body = await req.json().catch(() => ({}));
      const campaignId = body.campaign_id;
      if (!campaignId) throw new HttpError(400, "campaign_id_required");

      const { data: campaign } = await ctx.admin.from("campaigns")
        .select("status").eq("id", campaignId).maybeSingle();
      if (!campaign) throw new HttpError(404, "campaign_not_found");
      if (campaign.status !== "open") throw new HttpError(400, "campaign_not_open");

      const { data, error } = await ctx.admin.from("applications").insert({
        campaign_id: campaignId,
        influencer_id: ctx.userId,
        message: body.message ?? null,
      }).select("*").single();
      if (error) {
        if (error.code === "23505") throw new HttpError(409, "already_applied");
        throw new HttpError(400, error.message);
      }
      return ok({ application: data });
    }

    // LIST
    if (req.method === "GET" && !id) {
      const campaignId = url.searchParams.get("campaign_id");
      if (campaignId) {
        // company: applicants of one campaign (with influencer + tiktok stats)
        requireRole(ctx, "company");
        await ownsCampaign(campaignId);
        const { data, error } = await ctx.admin.from("applications")
          .select(
            "*, influencer:influencers(nickname, bio, profile:profiles(display_name, avatar_url), tiktok:tiktok_accounts(username, follower_count))",
          )
          .eq("campaign_id", campaignId)
          .order("applied_at", { ascending: false });
        if (error) throw new HttpError(400, error.message);
        return ok({ applications: data ?? [] });
      }
      // influencer: my applications (with campaign brief)
      requireRole(ctx, "influencer");
      const { data, error } = await ctx.admin.from("applications")
        .select(
          "*, campaign:campaigns(title, thumbnail_url, status, company:companies(company_name))",
        )
        .eq("influencer_id", ctx.userId)
        .order("applied_at", { ascending: false });
      if (error) throw new HttpError(400, error.message);
      return ok({ applications: data ?? [] });
    }

    // helper to load an application
    const loadApp = async (appId: string) => {
      const { data } = await ctx.admin.from("applications")
        .select("*, campaign:campaigns(company_id)").eq("id", appId).maybeSingle();
      if (!data) throw new HttpError(404, "application_not_found");
      return data;
    };

    // DECIDE (accept/reject) — campaign owner
    if (req.method === "POST" && id && action === "decide") {
      requireRole(ctx, "company");
      const app = await loadApp(id);
      if (app.campaign?.company_id !== ctx.userId) throw new HttpError(403, "not_owner");
      const body = await req.json().catch(() => ({}));
      const status = body.decision === "accept" ? "accepted" : "rejected";
      const { data, error } = await ctx.admin.from("applications")
        .update({ status, decided_at: new Date().toISOString() })
        .eq("id", id).select("*").single();
      if (error) throw new HttpError(400, error.message);
      return ok({ application: data });
    }

    // SUBMIT content — influencer who owns the application
    if (req.method === "POST" && id && action === "submit") {
      requireRole(ctx, "influencer");
      const app = await loadApp(id);
      if (app.influencer_id !== ctx.userId) throw new HttpError(403, "not_owner");
      if (app.status !== "accepted" && app.status !== "submitted") {
        throw new HttpError(400, "not_accepted");
      }
      const body = await req.json().catch(() => ({}));
      if (!body.content_url) throw new HttpError(400, "content_url_required");

      const { data: submission, error: sErr } = await ctx.admin.from("submissions")
        .insert({
          application_id: id,
          content_url: body.content_url,
          screenshot_url: body.screenshot_url ?? null,
          note: body.note ?? null,
        }).select("*").single();
      if (sErr) throw new HttpError(400, sErr.message);

      await ctx.admin.from("applications")
        .update({ status: "submitted" }).eq("id", id);
      return ok({ submission });
    }

    // CANCEL (withdraw) — influencer who owns a still-pending application
    if (req.method === "DELETE" && id && !action) {
      requireRole(ctx, "influencer");
      const app = await loadApp(id);
      if (app.influencer_id !== ctx.userId) throw new HttpError(403, "not_owner");
      if (app.status !== "pending") throw new HttpError(400, "cannot_cancel");
      const { error } = await ctx.admin.from("applications").delete().eq("id", id);
      if (error) throw new HttpError(400, error.message);
      return ok({ deleted: true });
    }

    throw new HttpError(404, "not_found");
  } catch (err) {
    return fail(err);
  }
});
