import { type SupabaseClient } from "jsr:@supabase/supabase-js@2";
import { HttpError } from "./respond.ts";
import { adminClient } from "./admin.ts";

export type Role = "company" | "influencer";

export interface AuthContext {
  userId: string;
  email: string;
  role: Role | null; // null until the user completes onboarding
  admin: SupabaseClient;
}

// Verifies the Supabase access token from the Authorization header and loads
// the caller's role. All authenticated routes start by calling this.
export async function authenticate(req: Request): Promise<AuthContext> {
  const header = req.headers.get("Authorization") ?? "";
  if (!header.startsWith("Bearer ")) throw new HttpError(401, "missing_authorization");
  const token = header.slice("Bearer ".length).trim();

  const admin = adminClient();
  const { data, error } = await admin.auth.getUser(token);
  if (error || !data.user) throw new HttpError(401, "invalid_token");

  const { data: profile } = await admin
    .from("profiles")
    .select("role")
    .eq("id", data.user.id)
    .maybeSingle();

  return {
    userId: data.user.id,
    email: data.user.email ?? "",
    role: (profile?.role as Role | undefined) ?? null,
    admin,
  };
}

export function requireRole(ctx: AuthContext, role: Role): void {
  if (ctx.role !== role) throw new HttpError(403, `requires_${role}_role`);
}
