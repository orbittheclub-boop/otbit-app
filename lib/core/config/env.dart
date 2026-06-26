import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration, loaded from the bundled `.env` file at startup
/// (see `main()` -> `dotenv.load`). Copy `.env.example` to `.env` and fill in.
/// These are public client keys (safe to ship).
///
/// AWS migration: change [supabaseUrl] / [functionsBaseUrl] in `.env` and swap
/// the token source in `AuthInterceptor` — nothing else references Supabase.
class Env {
  const Env._();

  static String get supabaseUrl => dotenv.get('SUPABASE_URL', fallback: '');

  /// Modern publishable key — used to initialise the Supabase SDK (auth).
  static String get supabasePublishableKey =>
      dotenv.get('SUPABASE_PUBLISHABLE_KEY', fallback: '');

  /// Legacy anon JWT — sent as the `apikey` header on Edge Function calls.
  static String get supabaseAnonKey =>
      dotenv.get('SUPABASE_ANON_KEY', fallback: '');

  /// Edge Functions are the ONLY data API the app talks to (Dio + Retrofit).
  static String get functionsBaseUrl => '$supabaseUrl/functions/v1/';
}
