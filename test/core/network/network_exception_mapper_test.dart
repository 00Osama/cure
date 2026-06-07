import 'package:cure/core/network/network_exception_mapper.dart';
import 'package:cure/shared/utils/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final req = RequestOptions(path: '/x');

  test('timeouts map to NetworkFailure', () {
    final f = mapDioError(
      DioException(
        requestOptions: req,
        type: DioExceptionType.connectionTimeout,
      ),
    );
    expect(f, isA<NetworkFailure>());
  });

  test('401/403 map to AuthFailure', () {
    for (final code in [401, 403]) {
      final f = mapDioError(
        DioException(
          requestOptions: req,
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: req, statusCode: code),
        ),
      );
      expect(f, isA<AuthFailure>(), reason: 'status $code');
    }
  });

  test('5xx maps to ServerFailure', () {
    final f = mapDioError(
      DioException(
        requestOptions: req,
        type: DioExceptionType.badResponse,
        response: Response(requestOptions: req, statusCode: 500),
      ),
    );
    expect(f, isA<ServerFailure>());
  });

  test('non-Dio errors map to ServerFailure', () {
    expect(mapDioError(Exception('boom')), isA<ServerFailure>());
  });

  test('an existing Failure passes through unchanged', () {
    const original = NetworkFailure('offline');
    expect(mapDioError(original), same(original));
  });
}
