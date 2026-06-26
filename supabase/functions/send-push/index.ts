import { authenticate } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";

// send-push (POST): admin-only. Sends an FCM push to a specific user's devices
// (profiles.fcm_tokens) via the FCM HTTP v1 API, and records an in-app
// notification. Requires the `FCM_SERVICE_ACCOUNT` secret (the Firebase service
// account JSON) and an admin caller (email in ADMIN_EMAILS).
//   body: { profile_id, title, body?, data? }

const ADMIN_EMAILS = (Deno.env.get("ADMIN_EMAILS") ??
  "orbittheclub@gmail.com,qwerty.2944@gmail.com")
  .split(",").map((s) => s.trim().toLowerCase()).filter(Boolean);

function pemToArrayBuffer(pem: string): ArrayBuffer {
  const b64 = pem
    .replace(/-----BEGIN [^-]+-----/, "")
    .replace(/-----END [^-]+-----/, "")
    .replace(/\s+/g, "");
  const bin = atob(b64);
  const buf = new Uint8Array(bin.length);
  for (let i = 0; i < bin.length; i++) buf[i] = bin.charCodeAt(i);
  return buf.buffer;
}

function base64url(input: Uint8Array | string): string {
  const bytes = typeof input === "string"
    ? new TextEncoder().encode(input)
    : input;
  let bin = "";
  for (const b of bytes) bin += String.fromCharCode(b);
  return btoa(bin).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

// Service-account JWT -> OAuth access token (scoped to FCM).
async function getAccessToken(
  sa: { client_email: string; private_key: string },
): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  const header = { alg: "RS256", typ: "JWT" };
  const claim = {
    iss: sa.client_email,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: "https://oauth2.googleapis.com/token",
    iat: now,
    exp: now + 3600,
  };
  const unsigned = `${base64url(JSON.stringify(header))}.${
    base64url(JSON.stringify(claim))
  }`;
  const key = await crypto.subtle.importKey(
    "pkcs8",
    pemToArrayBuffer(sa.private_key),
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"],
  );
  const sig = new Uint8Array(
    await crypto.subtle.sign(
      "RSASSA-PKCS1-v1_5",
      key,
      new TextEncoder().encode(unsigned),
    ),
  );
  const jwt = `${unsigned}.${base64url(sig)}`;
  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });
  const j = await res.json();
  if (!j.access_token) {
    throw new HttpError(500, `token_exchange_failed: ${JSON.stringify(j)}`);
  }
  return j.access_token as string;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const ctx = await authenticate(req);
    if (req.method !== "POST") throw new HttpError(404, "not_found");
    if (!ADMIN_EMAILS.includes(ctx.email.toLowerCase())) {
      throw new HttpError(403, "not_admin");
    }

    const body = await req.json().catch(() => ({}));
    const profileId = body.profile_id;
    const title = body.title;
    const text = body.body ?? "";
    if (!profileId || !title) {
      throw new HttpError(400, "profile_id_and_title_required");
    }

    const saRaw = Deno.env.get("FCM_SERVICE_ACCOUNT");
    if (!saRaw) throw new HttpError(500, "FCM_SERVICE_ACCOUNT_not_configured");
    const sa = JSON.parse(saRaw);

    const { data: prof } = await ctx.admin.from("profiles")
      .select("fcm_tokens").eq("id", profileId).maybeSingle();
    const tokens: string[] = Array.isArray(prof?.fcm_tokens)
      ? prof!.fcm_tokens as string[]
      : [];

    // Record an in-app notification too (best-effort).
    await ctx.admin.from("notifications").insert({
      profile_id: profileId,
      type: "admin",
      title,
      body: text || null,
    });

    if (tokens.length === 0) return ok({ sent: 0, note: "no_tokens" });

    const accessToken = await getAccessToken(sa);
    const projectId = sa.project_id;
    let sent = 0;
    const invalid: string[] = [];

    for (const token of tokens) {
      const r = await fetch(
        `https://fcm.googleapis.com/v1/projects/${projectId}/messages:send`,
        {
          method: "POST",
          headers: {
            Authorization: `Bearer ${accessToken}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            message: {
              token,
              notification: { title, body: text },
              data: body.data ?? {},
            },
          }),
        },
      );
      if (r.ok) {
        sent++;
      } else {
        const e = JSON.stringify(await r.json().catch(() => ({})));
        if (e.includes("UNREGISTERED") || e.includes("NOT_FOUND")) {
          invalid.push(token);
        }
      }
    }

    // Prune dead tokens.
    if (invalid.length) {
      const remaining = tokens.filter((t) => !invalid.includes(t));
      await ctx.admin.from("profiles")
        .update({ fcm_tokens: remaining }).eq("id", profileId);
    }

    return ok({ sent, invalid: invalid.length, total: tokens.length });
  } catch (err) {
    return fail(err);
  }
});
