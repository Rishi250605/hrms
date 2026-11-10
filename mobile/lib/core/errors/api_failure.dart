import 'package:dio/dio.dart';

/// A failed API call, normalised from the API's `{ error: { code, message, details } }` body
/// or from a transport error.
class ApiFailure implements Exception {
  const ApiFailure({required this.code, required this.message, this.statusCode, this.details});

  /// Server error code (e.g. `INVALID_OTP`, `DOCUMENT_INVALID`) or a client code
  /// (`NETWORK_ERROR`, `UNKNOWN_ERROR`).
  final String code;
  final String message;
  final int? statusCode;
  final Object? details;

  static const networkError = 'NETWORK_ERROR';
  static const unknownError = 'UNKNOWN_ERROR';

  bool get isNetwork => code == networkError;

  factory ApiFailure.fromObject(Object error) {
    if (error is ApiFailure) return error;
    if (error is DioException) return ApiFailure.fromDio(error);
    return ApiFailure(code: unknownError, message: error.toString());
  }

  factory ApiFailure.fromDio(DioException e) {
    const transportErrors = {
      DioExceptionType.connectionTimeout,
      DioExceptionType.sendTimeout,
      DioExceptionType.receiveTimeout,
      DioExceptionType.connectionError,
    };
    if (transportErrors.contains(e.type)) {
      return ApiFailure(code: networkError, message: e.message ?? 'Network error');
    }
    final response = e.response;
    final data = response?.data;
    if (data is Map && data['error'] is Map) {
      final err = data['error'] as Map;
      return ApiFailure(
        code: err['code']?.toString() ?? unknownError,
        message: err['message']?.toString() ?? 'Request failed',
        statusCode: response?.statusCode,
        details: err['details'],
      );
    }
    return ApiFailure(code: unknownError, message: e.message ?? 'Request failed', statusCode: response?.statusCode);
  }

  @override
  String toString() => 'ApiFailure($code, $statusCode): $message';
}
