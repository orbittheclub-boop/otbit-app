import 'package:dio/dio.dart';

/// Retries transient failures — chiefly Edge Function cold-start `502`s and
/// flaky connections — with a short backoff. Cold-start 5xx errors never reach
/// the function body, so retrying is safe (and writes are upserts/guarded).
class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio, {this.maxRetries = 2});

  final Dio _dio;
  final int maxRetries;

  static const _retriableStatus = {502, 503, 504};

  bool _shouldRetry(DioException e) {
    final status = e.response?.statusCode;
    if (status != null && _retriableStatus.contains(status)) return true;
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final attempt = (err.requestOptions.extra['retry_attempt'] as int?) ?? 0;
    if (attempt < maxRetries && _shouldRetry(err)) {
      final next = attempt + 1;
      await Future<void>.delayed(Duration(milliseconds: 350 * next));
      final options = err.requestOptions..extra['retry_attempt'] = next;
      try {
        final response = await _dio.fetch<dynamic>(options);
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.next(e);
      }
    }
    handler.next(err);
  }
}
