import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:orbit/core/config/env.dart';

/// Attaches the Supabase anon `apikey` and the signed-in user's access token to
/// every Edge Function request. On a 401 it refreshes the session once and
/// retries. This is the single seam to replace when moving auth to AWS Cognito.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._client);

  final SupabaseClient _client;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['apikey'] = Env.supabaseAnonKey;
    final token = _client.auth.currentSession?.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final res = await _client.auth.refreshSession();
        final token = res.session?.accessToken;
        if (token != null) {
          final req = err.requestOptions
            ..headers['Authorization'] = 'Bearer $token';
          final retry = await Dio().fetch<dynamic>(req);
          return handler.resolve(retry);
        }
      } catch (_) {
        // fall through to surfacing the original error
      }
    }
    handler.next(err);
  }
}
