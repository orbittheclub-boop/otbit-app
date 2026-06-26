// AES-GCM encryption for OAuth tokens at rest. TOKEN_ENCRYPTION_KEY must be a
// base64-encoded 32-byte key. If it is not set (dev), tokens are stored as-is.
const KEY_B64 = Deno.env.get("TOKEN_ENCRYPTION_KEY") ?? "";

function b64ToBytes(b64: string): Uint8Array {
  return Uint8Array.from(atob(b64), (c) => c.charCodeAt(0));
}

function bytesToB64(bytes: Uint8Array): string {
  return btoa(String.fromCharCode(...bytes));
}

async function getKey(): Promise<CryptoKey> {
  return crypto.subtle.importKey(
    "raw",
    b64ToBytes(KEY_B64),
    { name: "AES-GCM" },
    false,
    ["encrypt", "decrypt"],
  );
}

export async function encryptToken(plain: string): Promise<string> {
  if (!KEY_B64) return plain;
  const key = await getKey();
  const iv = crypto.getRandomValues(new Uint8Array(12));
  const ct = new Uint8Array(
    await crypto.subtle.encrypt(
      { name: "AES-GCM", iv },
      key,
      new TextEncoder().encode(plain),
    ),
  );
  const out = new Uint8Array(iv.length + ct.length);
  out.set(iv);
  out.set(ct, iv.length);
  return bytesToB64(out);
}

export async function decryptToken(payload: string): Promise<string> {
  if (!KEY_B64) return payload;
  const key = await getKey();
  const raw = b64ToBytes(payload);
  const iv = raw.slice(0, 12);
  const ct = raw.slice(12);
  const pt = await crypto.subtle.decrypt({ name: "AES-GCM", iv }, key, ct);
  return new TextDecoder().decode(pt);
}
