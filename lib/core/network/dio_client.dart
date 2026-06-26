import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:orbit/core/config/env.dart';
import 'package:orbit/core/network/auth_interceptor.dart';
import 'package:orbit/core/network/retry_interceptor.dart';

/// Builds the Dio instance pointed at Supabase Edge Functions. Retrofit API
/// services are constructed from this single client.
class DioClient {
  const DioClient._();

  static Dio create(SupabaseClient client) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.functionsBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        contentType: 'application/json',
        headers: {'Accept': 'application/json'},
      ),
    );
    dio.interceptors.add(AuthInterceptor(client));
    dio.interceptors.add(RetryInterceptor(dio));
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: false,
        compact: true,
      ),
    );
    return dio;
  }
}
