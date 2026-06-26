import { createClient, type SupabaseClient } from "jsr:@supabase/supabase-js@2";

// Service-role client. RLS is disabled on all tables and direct grants are
// revoked from anon/authenticated, so this is the ONLY way to reach the data.
// SUPABASE_URL / SUPABASE_SERVICE_ROLE_KEY are auto-injected into Edge Functions.
export function adminClient(): SupabaseClient {
  return createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    { auth: { persistSession: false, autoRefreshToken: false } },
  );
}
