import { corsHeaders } from "./cors.ts";

// Uniform JSON envelope: success -> { data }, error -> { error }.
export function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

export function ok(data: unknown, status = 200): Response {
  return json({ data }, status);
}

// Throw this anywhere in a handler to return a controlled HTTP error.
export class HttpError extends Error {
  status: number;
  constructor(status: number, message: string) {
    super(message);
    this.status = status;
  }
}

export function fail(err: unknown): Response {
  if (err instanceof HttpError) return json({ error: err.message }, err.status);
  console.error("[edge] unhandled error:", err);
  return json({ error: "internal_error" }, 500);
}
