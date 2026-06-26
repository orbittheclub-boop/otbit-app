import { authenticate, requireRole } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";
import { decode as decodeJpeg } from "https://esm.sh/@jsquash/jpeg@1";
import { decode as decodePng } from "https://esm.sh/@jsquash/png@3";
import { encode as encodeWebp } from "https://esm.sh/@jsquash/webp@1";
import resize from "https://esm.sh/@jsquash/resize@2";

// campaign-image (POST): raw image bytes in body, content-type image/jpeg|png.
// Company-only. Downscales to max 1280px, re-encodes to WebP, stores in the
// `campaign-images` bucket, and returns the public URL (thumbnail_url).
Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const ctx = await authenticate(req);
    requireRole(ctx, "company");
    if (req.method !== "POST") throw new HttpError(404, "not_found");

    const buf = await req.arrayBuffer();
    if (buf.byteLength === 0) throw new HttpError(400, "empty_body");

    const ct = req.headers.get("content-type") ?? "";
    const image = ct.includes("png")
      ? await decodePng(buf)
      : await decodeJpeg(buf);

    const max = 1280;
    const scale = Math.min(max / image.width, max / image.height, 1);
    const out = scale < 1
      ? await resize(image, {
          width: Math.round(image.width * scale),
          height: Math.round(image.height * scale),
        })
      : image;

    const webp = await encodeWebp(out, { quality: 80 });

    const path = `${ctx.userId}/${crypto.randomUUID()}.webp`;
    const { error: upErr } = await ctx.admin.storage.from("campaign-images")
      .upload(path, new Uint8Array(webp), {
        contentType: "image/webp",
        upsert: true,
      });
    if (upErr) throw new HttpError(400, upErr.message);

    const { data: pub } = ctx.admin.storage.from("campaign-images")
      .getPublicUrl(path);

    return ok({ url: pub.publicUrl, bytes: webp.byteLength });
  } catch (err) {
    return fail(err);
  }
});
