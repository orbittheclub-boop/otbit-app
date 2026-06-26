import { authenticate, type AuthContext } from "../_shared/auth.ts";
import { ok, fail, HttpError } from "../_shared/respond.ts";
import { corsHeaders } from "../_shared/cors.ts";

// board function — Picky-style community board (posts / likes / comments).
//   GET    /board?category=        -> post feed (+ liked flag for caller)
//   GET    /board/:id              -> post detail + comments (+ liked)
//   POST   /board                  -> create post { category, title, body }
//   PATCH  /board/:id              -> edit (author only)
//   DELETE /board/:id              -> delete (author only)
//   POST   /board/:id/like         -> toggle like -> { liked, like_count }
//   POST   /board/:id/comments     -> add comment { body }
//   DELETE /board/:id/comments/:cid-> delete comment (author only)
//
// Authors are attached with a separate profiles query (not a PostgREST embed)
// so the feature does not depend on the relationship schema cache.
const CATEGORIES = ["free", "question", "tip", "review"];

// deno-lint-ignore no-explicit-any
type Row = Record<string, any>;

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });

  try {
    const ctx = await authenticate(req);
    const url = new URL(req.url);
    const segs = url.pathname.split("/").filter(Boolean);
    const i = segs.indexOf("board");
    const id = i >= 0 ? segs[i + 1] : undefined;
    const action = i >= 0 ? segs[i + 2] : undefined;
    const sub = i >= 0 ? segs[i + 3] : undefined; // comment id

    // LIST
    if (req.method === "GET" && !id) {
      const category = url.searchParams.get("category");
      let q = ctx.admin.from("board_posts").select("*")
        .order("created_at", { ascending: false }).limit(100);
      if (category) q = q.eq("category", category);
      const { data, error } = await q;
      if (error) throw new HttpError(400, error.message);
      const posts = await attachAuthors(ctx, data ?? []);
      const liked = await likedSet(ctx, posts.map((p) => p.id));
      return ok({ posts: posts.map((p) => ({ ...p, liked: liked.has(p.id) })) });
    }

    // DETAIL (+ comments)
    if (req.method === "GET" && id && !action) {
      const { data: post, error } = await ctx.admin.from("board_posts")
        .select("*").eq("id", id).maybeSingle();
      if (error) throw new HttpError(400, error.message);
      if (!post) throw new HttpError(404, "post_not_found");
      const { data: comments } = await ctx.admin.from("board_comments")
        .select("*").eq("post_id", id).order("created_at", { ascending: true });
      const [withAuthor] = await attachAuthors(ctx, [post]);
      const liked = await likedSet(ctx, [id]);
      return ok({
        post: { ...withAuthor, liked: liked.has(id) },
        comments: await attachAuthors(ctx, comments ?? []),
      });
    }

    // CREATE
    if (req.method === "POST" && !id) {
      const body = await req.json().catch(() => ({}));
      const category = String(body.category ?? "");
      if (!CATEGORIES.includes(category)) throw new HttpError(400, "invalid_category");
      if (!body.title || !body.body) throw new HttpError(400, "title_and_body_required");
      const { data, error } = await ctx.admin.from("board_posts").insert({
        author_id: ctx.userId,
        category,
        title: body.title,
        body: body.body,
      }).select("*").single();
      if (error) throw new HttpError(400, error.message);
      const [withAuthor] = await attachAuthors(ctx, [data]);
      return ok({ post: { ...withAuthor, liked: false } });
    }

    const assertAuthor = async (table: string, rowId: string) => {
      const { data } = await ctx.admin.from(table)
        .select("author_id").eq("id", rowId).maybeSingle();
      if (!data) throw new HttpError(404, "not_found");
      if (data.author_id !== ctx.userId) throw new HttpError(403, "not_author");
    };

    // LIKE toggle
    if (req.method === "POST" && id && action === "like") {
      const { data: existing } = await ctx.admin.from("board_likes")
        .select("post_id").eq("post_id", id).eq("profile_id", ctx.userId).maybeSingle();
      let liked: boolean;
      if (existing) {
        await ctx.admin.from("board_likes").delete()
          .eq("post_id", id).eq("profile_id", ctx.userId);
        liked = false;
      } else {
        const { error } = await ctx.admin.from("board_likes")
          .insert({ post_id: id, profile_id: ctx.userId });
        if (error && error.code !== "23505") throw new HttpError(400, error.message);
        liked = true;
      }
      const { data: post } = await ctx.admin.from("board_posts")
        .select("like_count").eq("id", id).maybeSingle();
      return ok({ liked, like_count: post?.like_count ?? 0 });
    }

    // ADD COMMENT
    if (req.method === "POST" && id && action === "comments") {
      const body = await req.json().catch(() => ({}));
      if (!body.body) throw new HttpError(400, "body_required");
      const { data, error } = await ctx.admin.from("board_comments").insert({
        post_id: id,
        author_id: ctx.userId,
        body: body.body,
      }).select("*").single();
      if (error) throw new HttpError(400, error.message);
      const [withAuthor] = await attachAuthors(ctx, [data]);
      return ok({ comment: withAuthor });
    }

    // DELETE COMMENT
    if (req.method === "DELETE" && id && action === "comments" && sub) {
      await assertAuthor("board_comments", sub);
      const { error } = await ctx.admin.from("board_comments").delete().eq("id", sub);
      if (error) throw new HttpError(400, error.message);
      return ok({ deleted: true });
    }

    // UPDATE POST (author only)
    if (req.method === "PATCH" && id && !action) {
      await assertAuthor("board_posts", id);
      const body = await req.json().catch(() => ({}));
      const patch: Record<string, unknown> = {};
      for (const k of ["category", "title", "body"]) if (k in body) patch[k] = body[k];
      if (patch.category && !CATEGORIES.includes(patch.category as string)) {
        throw new HttpError(400, "invalid_category");
      }
      patch.updated_at = new Date().toISOString();
      const { data, error } = await ctx.admin.from("board_posts")
        .update(patch).eq("id", id).select("*").single();
      if (error) throw new HttpError(400, error.message);
      const [withAuthor] = await attachAuthors(ctx, [data]);
      return ok({ post: withAuthor });
    }

    // DELETE POST (author only)
    if (req.method === "DELETE" && id && !action) {
      await assertAuthor("board_posts", id);
      const { error } = await ctx.admin.from("board_posts").delete().eq("id", id);
      if (error) throw new HttpError(400, error.message);
      return ok({ deleted: true });
    }

    throw new HttpError(404, "not_found");
  } catch (err) {
    return fail(err);
  }
});

// Attaches an `author` object ({ display_name, avatar_url, role }) to each row
// by looking up author_id in profiles — no PostgREST embed required.
async function attachAuthors(ctx: AuthContext, rows: Row[]): Promise<Row[]> {
  if (rows.length === 0) return rows;
  const ids = [...new Set(rows.map((r) => r.author_id))];
  const { data } = await ctx.admin.from("profiles")
    .select("id, display_name, avatar_url, role").in("id", ids);
  const map = new Map((data ?? []).map((p) => [p.id, p]));
  return rows.map((r) => ({ ...r, author: map.get(r.author_id) ?? null }));
}

// Set of post ids the caller has liked, among the given ids.
async function likedSet(ctx: AuthContext, ids: string[]): Promise<Set<string>> {
  if (ids.length === 0) return new Set();
  const { data } = await ctx.admin.from("board_likes")
    .select("post_id").eq("profile_id", ctx.userId).in("post_id", ids);
  return new Set((data ?? []).map((r) => r.post_id as string));
}
