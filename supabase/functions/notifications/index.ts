import { authenticate } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";

// notifications function
//   GET  /notifications                   -> list + unread count
//   POST /notifications/read              -> mark one ({id}) or all read
//   POST /notifications/register-device   -> add an FCM token (profiles.fcm_tokens)
//   POST /notifications/unregister-device -> remove an FCM token (on sign-out)
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

    // Store the caller's FCM token in profiles.fcm_tokens (jsonb array, deduped,
    // capped to the 10 most recent devices). Also mirrors device_tokens.
    if (req.method === "POST" && action === "register-device") {
      const body = await req.json().catch(() => ({}));
      const token = body.fcm_token;
      if (!token) throw new HttpError(400, "fcm_token_required");

      const { data: prof } = await ctx.admin.from("profiles")
        .select("fcm_tokens").eq("id", ctx.userId).maybeSingle();
      const tokens: string[] = Array.isArray(prof?.fcm_tokens)
        ? prof!.fcm_tokens as string[]
        : [];
      if (!tokens.includes(token)) {
        const next = [...tokens, token].slice(-10);
        const { error } = await ctx.admin.from("profiles")
          .update({ fcm_tokens: next }).eq("id", ctx.userId);
        if (error) throw new HttpError(400, error.message);
      }
      await ctx.admin.from("device_tokens").upsert({
        profile_id: ctx.userId,
        fcm_token: token,
        platform: body.platform ?? null,
        updated_at: new Date().toISOString(),
      }, { onConflict: "profile_id,fcm_token" });
      return ok({ registered: true });
    }

    if (req.method === "POST" && action === "unregister-device") {
      const body = await req.json().catch(() => ({}));
      const token = body.fcm_token;
      if (!token) throw new HttpError(400, "fcm_token_required");
      const { data: prof } = await ctx.admin.from("profiles")
        .select("fcm_tokens").eq("id", ctx.userId).maybeSingle();
      const tokens: string[] = Array.isArray(prof?.fcm_tokens)
        ? prof!.fcm_tokens as string[]
        : [];
      const next = tokens.filter((t) => t !== token);
      await ctx.admin.from("profiles")
        .update({ fcm_tokens: next }).eq("id", ctx.userId);
      await ctx.admin.from("device_tokens").delete()
        .eq("profile_id", ctx.userId).eq("fcm_token", token);
      return ok({ unregistered: true });
    }

    throw new HttpError(404, "not_found");
  } catch (err) {
    return fail(err);
  }
});
