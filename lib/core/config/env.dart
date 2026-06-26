import 'package:envied/envied.dart';

part 'env.g.dart';

/// Environment configuration, generated from the bundled `.env` file at BUILD
/// time by `envied` (run `build_runner`). Copy `.env.example` to `.env` and
/// fill in. Values are obfuscated in the generated `env.g.dart`.
///
/// AWS migration: change `SUPABASE_URL` in `.env`, regenerate, and swap the
/// token source in `AuthInterceptor` — nothing else references Supabase.
@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'SUPABASE_URL')
  static final String supabaseUrl = _Env.supabaseUrl;

  /// Modern publishable key — used to initialise the Supabase SDK (auth).
  @EnviedField(varName: 'SUPABASE_PUBLISHABLE_KEY')
  static final String supabasePublishableKey = _Env.supabasePublishableKey;

  /// Legacy anon JWT — sent as the `apikey` header on Edge Function calls.
  @EnviedField(varName: 'SUPABASE_ANON_KEY')
  static final String supabaseAnonKey = _Env.supabaseAnonKey;

  /// Google native sign-in — the iOS OAuth client id (public, also in the
  /// iOS URL scheme). Add the same id to Supabase Auth → Google → Client IDs.
  @EnviedField(varName: 'GOOGLE_IOS_CLIENT_ID', defaultValue: '')
  static final String googleIosClientId = _Env.googleIosClientId;

  /// Google "web" OAuth client id — used as the serverClientId so the ID token
  /// audience is consistent across iOS/Android; also configured in Supabase.
  @EnviedField(varName: 'GOOGLE_WEB_CLIENT_ID', defaultValue: '')
  static final String googleWebClientId = _Env.googleWebClientId;

  /// Edge Functions are the ONLY data API the app talks to (Dio + Retrofit).
  static String get functionsBaseUrl => '$supabaseUrl/functions/v1/';
}
