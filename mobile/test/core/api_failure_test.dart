import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_app/core/errors/api_failure.dart';

void main() {
  final request = RequestOptions(path: '/x');

  test('parses the API error envelope', () {
    final failure = ApiFailure.fromDio(
      DioException(
        requestOptions: request,
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: request,
          statusCode: 401,
          data: {
            'error': {
              'code': 'INVALID_OTP',
              'message': 'The OTP is incorrect or has expired',
              'details': {'attemptsRemaining': 3},
            },
          },
        ),
      ),
    );
    expect(failure.code, 'INVALID_OTP');
    expect(failure.statusCode, 401);
    expect(failure.message, contains('incorrect'));
    expect(failure.details, {'attemptsRemaining': 3});
  });

  test('maps transport errors to NETWORK_ERROR', () {
    for (final type in [
      DioExceptionType.connectionError,
      DioExceptionType.connectionTimeout,
      DioExceptionType.receiveTimeout,
    ]) {
      final failure = ApiFailure.fromDio(DioException(requestOptions: request, type: type));
      expect(failure.isNetwork, isTrue, reason: '$type');
    }
  });

  test('falls back to UNKNOWN_ERROR for non-envelope bodies', () {
    final failure = ApiFailure.fromDio(
      DioException(
        requestOptions: request,
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: request, statusCode: 502, data: '<html>Bad gateway</html>'),
      ),
    );
    expect(failure.code, ApiFailure.unknownError);
    expect(failure.statusCode, 502);
  });
}
