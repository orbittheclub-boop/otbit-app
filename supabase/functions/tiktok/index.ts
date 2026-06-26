import { authenticate, requireRole } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { encryptToken, decryptToken } from "../_shared/crypto.ts";

const CLIENT_KEY = Deno.env.get("TIKTOK_CLIENT_KEY") ?? "";
const CLIENT_SECRET = Deno.env.get("TIKTOK_CLIENT_SECRET") ?? "";
const REDIRECT_URI = Deno.env.get("TIKTOK_REDIRECT_URI") ?? "";
const SCOPES = "user.info.basic,user.info.profile,user.info.stats";
const PUBLIC_FIELDS =
  "open_id, username, display_name, avatar_url, follower_count, following_count, likes_count, video_count, verified_at, last_synced_at";

function randomState(): string {
  const a = crypto.getRandomValues(new Uint8Array(16));
  return btoa(String.fromCharCode(...a)).replace(/[^a-zA-Z0-9]/g, "").slice(0, 24);
}

async function fetchUserInfo(accessToken: string) {
  const fields =
    "open_id,union_id,avatar_url,display_name,username,follower_count,following_count,likes_count,video_count";
  const res = await fetch(
    `https://open.tiktokapis.com/v2/user/info/?fields=${fields}`,
    { headers: { Authorization: `Bearer ${accessToken}` } },
  );
  const json = await res.json();
  return json?.data?.user ?? null;
}

// tiktok function (influencer only)
//   GET    /tiktok/authorize-url  -> { url, state } to open in a browser
//   POST   /tiktok/callback       -> { code } exchange + store + fetch stats
//   GET    /tiktok                -> linked account (public fields)
//   POST   /tiktok/refresh-stats  -> re-sync stats (refreshes token if needed)
//   DELETE /tiktok                -> unlink
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const ctx = await authenticate(req);
    const url = new URL(req.url);
    const segs = url.pathname.split("/").filter(Boolean);
    const i = segs.indexOf("tiktok");
    const action = i >= 0 ? segs[i + 1] : undefined;

    if (req.method === "GET" && action === "authorize-url") {
      requireRole(ctx, "influencer");
      if (!CLIENT_KEY || !REDIRECT_URI) throw new HttpError(400, "tiktok_not_configured");
      const state = randomState();
      const authUrl = new URL("https://www.tiktok.com/v2/auth/authorize/");
      authUrl.searchParams.set("client_key", CLIENT_KEY);
      authUrl.searchParams.set("scope", SCOPES);
      authUrl.searchParams.set("response_type", "code");
      authUrl.searchParams.set("redirect_uri", REDIRECT_URI);
      authUrl.searchParams.set("state", state);
      return ok({ url: authUrl.toString(), state });
    }

    if (req.method === "POST" && action === "callback") {
      requireRole(ctx, "influencer");
      if (!CLIENT_KEY || !CLIENT_SECRET || !REDIRECT_URI) {
        throw new HttpError(400, "tiktok_not_configured");
      }
      const body = await req.json().catch(() => ({}));
      if (!body.code) throw new HttpError(400, "code_required");

      const tokenRes = await fetch("https://open.tiktokapis.com/v2/oauth/token/", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
          client_key: CLIENT_KEY,
          client_secret: CLIENT_SECRET,
          code: body.code,
          grant_type: "authorization_code",
          redirect_uri: REDIRECT_URI,
        }),
      });
      const token = await tokenRes.json();
      if (!token.access_token) {
        throw new HttpError(400, token.error_description ?? "token_exchange_failed");
      }
      const user = await fetchUserInfo(token.access_token);

      const row = {
        influencer_id: ctx.userId,
        open_id: token.open_id ?? user?.open_id ?? "",
        union_id: user?.union_id ?? null,
        username: user?.username ?? null,
        display_name: user?.display_name ?? null,
        avatar_url: user?.avatar_url ?? null,
        follower_count: user?.follower_count ?? null,
        following_count: user?.following_count ?? null,
        likes_count: user?.likes_count ?? null,
        video_count: user?.video_count ?? null,
        access_token_enc: await encryptToken(token.access_token),
        refresh_token_enc: token.refresh_token
          ? await encryptToken(token.refresh_token)
          : null,
        token_expires_at: token.expires_in
          ? new Date(Date.now() + token.expires_in * 1000).toISOString()
          : null,
        scopes: (token.scope ?? SCOPES).split(","),
        verified_at: new Date().toISOString(),
        last_synced_at: new Date().toISOString(),
      };
      const { data, error } = await ctx.admin.from("tiktok_accounts")
        .upsert(row, { onConflict: "influencer_id" }).select(PUBLIC_FIELDS).single();
      if (error) throw new HttpError(400, error.message);
      return ok({ tiktok: data });
    }

    if (req.method === "GET" && !action) {
      const { data } = await ctx.admin.from("tiktok_accounts")
        .select(PUBLIC_FIELDS).eq("influencer_id", ctx.userId).maybeSingle();
      return ok({ tiktok: data });
    }

    if (req.method === "POST" && action === "refresh-stats") {
      requireRole(ctx, "influencer");
      const { data: acct } = await ctx.admin.from("tiktok_accounts")
        .select("access_token_enc, refresh_token_enc, token_expires_at")
        .eq("influencer_id", ctx.userId).maybeSingle();
      if (!acct) throw new HttpError(404, "not_linked");

      let accessToken = await decryptToken(acct.access_token_enc);
      const expired = acct.token_expires_at &&
        new Date(acct.token_expires_at) < new Date();
      if (expired && acct.refresh_token_enc && CLIENT_KEY && CLIENT_SECRET) {
        const refreshToken = await decryptToken(acct.refresh_token_enc);
        const r = await fetch("https://open.tiktokapis.com/v2/oauth/token/", {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body: new URLSearchParams({
            client_key: CLIENT_KEY,
            client_secret: CLIENT_SECRET,
            grant_type: "refresh_token",
            refresh_token: refreshToken,
          }),
        });
        const t = await r.json();
        if (t.access_token) {
          accessToken = t.access_token;
          await ctx.admin.from("tiktok_accounts").update({
            access_token_enc: await encryptToken(t.access_token),
            refresh_token_enc: t.refresh_token
              ? await encryptToken(t.refresh_token)
              : acct.refresh_token_enc,
            token_expires_at: t.expires_in
              ? new Date(Date.now() + t.expires_in * 1000).toISOString()
              : null,
          }).eq("influencer_id", ctx.userId);
        }
      }

      const user = await fetchUserInfo(accessToken);
      if (!user) throw new HttpError(400, "fetch_failed");
      const { data, error } = await ctx.admin.from("tiktok_accounts").update({
        username: user.username ?? null,
        display_name: user.display_name ?? null,
        avatar_url: user.avatar_url ?? null,
        follower_count: user.follower_count ?? null,
        following_count: user.following_count ?? null,
        likes_count: user.likes_count ?? null,
        video_count: user.video_count ?? null,
        last_synced_at: new Date().toISOString(),
      }).eq("influencer_id", ctx.userId).select(PUBLIC_FIELDS).single();
      if (error) throw new HttpError(400, error.message);
      return ok({ tiktok: data });
    }

    if (req.method === "DELETE") {
      requireRole(ctx, "influencer");
      await ctx.admin.from("tiktok_accounts").delete().eq("influencer_id", ctx.userId);
      return ok({ unlinked: true });
    }

    throw new HttpError(404, "not_found");
  } catch (err) {
    return fail(err);
  }
});
