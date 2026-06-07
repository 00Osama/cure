import 'dart:async';

import 'package:dio/dio.dart';

/// Retries transient failures (timeouts, connection errors, 5xx) using
/// exponential backoff.
///
/// Only idempotent methods (GET/HEAD/PUT/DELETE) are retried, so a non-
/// idempotent booking `POST` is never duplicated by a retry.
class RetryInterceptor extends Interceptor {
  RetryInterceptor(
    this._dio, {
    this.maxRetries = 3,
    this.baseDelay = const Duration(milliseconds: 300),
  });

  final Dio _dio;
  final int maxRetries;
  final Duration baseDelay;

  static const String _attemptKey = 'retry_attempt';
  static const Set<String> _idempotent = {'GET', 'HEAD', 'PUT', 'DELETE'};

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = (options.extra[_attemptKey] as int?) ?? 0;

    final canRetry =
        attempt < maxRetries &&
        _isRetryable(err) &&
        _idempotent.contains(options.method.toUpperCase());
    if (!canRetry) {
      return handler.next(err);
    }

    // 300ms, 600ms, 1200ms ...
    await Future<void>.delayed(baseDelay * (1 << attempt));
    options.extra[_attemptKey] = attempt + 1;

    try {
      final response = await _dio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  bool _isRetryable(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        return (err.response?.statusCode ?? 0) >= 500;
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return false;
    }
  }
}
