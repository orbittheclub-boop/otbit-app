/// Thrown by data sources. Carries the server-provided error code/message that
/// the repository converts into a [Failure].
class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}
