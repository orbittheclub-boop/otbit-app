import { authenticate } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";

// notifications function
//   GET  /notifications                  -> list + unread count
//   POST /notifications/read             -> mark one ({id}) or all read
//   POST /notifications/register-device  -> store an FCM token
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const ctx = await authenticate(req);
    const url = new URL(req.url);
    const segs = url.pathname.split("/").filter(Boolean);
    const i = segs.indexOf("notifications");
    const action = i >= 0 ? segs[i + 1] : undefined;

    if (req.method === "GET" && !action) {
      const { data, error } = await ctx.admin.from("notifications")
        .select("*").eq("profile_id", ctx.userId)
        .order("created_at", { ascending: false }).limit(100);
      if (error) throw new HttpError(400, error.message);
      const unread = (data ?? []).filter((n) => !n.read_at).length;
      return ok({ notifications: data ?? [], unread });
    }

    if (req.method === "POST" && action === "read") {
      const body = await req.json().catch(() => ({}));
      const now = new Date().toISOString();
      let q = ctx.admin.from("notifications").update({ read_at: now })
        .eq("profile_id", ctx.userId);
      if (body.id) q = q.eq("id", body.id);
      else q = q.is("read_at", null);
      const { error } = await q;
      if (error) throw new HttpError(400, error.message);
      return ok({ ok: true });
    }

    if (req.method === "POST" && action === "register-device") {
      const body = await req.json().catch(() => ({}));
      if (!body.fcm_token) throw new HttpError(400, "fcm_token_required");
      const { error } = await ctx.admin.from("device_tokens").upsert({
        profile_id: ctx.userId,
        fcm_token: body.fcm_token,
        platform: body.platform ?? null,
        updated_at: new Date().toISOString(),
      }, { onConflict: "profile_id,fcm_token" });
      if (error) throw new HttpError(400, error.message);
      return ok({ registered: true });
    }

    throw new HttpError(404, "not_found");
  } catch (err) {
    return fail(err);
  }
});
