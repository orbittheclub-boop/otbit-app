import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException;

import 'package:orbit/core/error/failure.dart';
import 'package:orbit/core/usecase/usecase.dart';

/// Runs a network call and converts any thrown error into a [Failure], so the
/// repository/use-case layers can return [Result] without try/catch noise.
Future<Result<T>> guard<T>(Future<T> Function() run) async {
  try {
    return Ok(await run());
  } on DioException catch (e) {
    return Err(_mapDioError(e));
  } on AuthException catch (e) {
    return Err(AuthFailure(e.message));
  } catch (e) {
    return Err(UnknownFailure(e.toString()));
  }
}

Failure _mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      final status = e.response?.statusCode;
      final data = e.response?.data;
      if (status != null && status >= 500) {
        return ServerFailure('서버가 잠시 불안정해요. 잠시 후 다시 시도해주세요.',
            statusCode: status);
      }
      final message = data is Map && data['error'] is String
          ? data['error'] as String
          : '요청을 처리하지 못했습니다.';
      if (status == 401 || status == 403) return AuthFailure(message);
      return ServerFailure(message, statusCode: status);
    default:
      return const UnknownFailure();
  }
}
