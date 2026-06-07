import 'dart:typed_data';

import 'package:cure/core/network/interceptors/retry_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Adapter that returns a queued sequence of status codes, counting calls.
class _CountingAdapter implements HttpClientAdapter {
  _CountingAdapter(this.statusCodes);

  final List<int> statusCodes;
  int calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final code = calls < statusCodes.length
        ? statusCodes[calls]
        : statusCodes.last;
    calls++;
    return ResponseBody.fromString(
      '[]',
      code,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Dio _dioWith(_CountingAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.test/'));
  dio.httpClientAdapter = adapter;
  dio.interceptors.add(
    RetryInterceptor(
      dio,
      maxRetries: 3,
      baseDelay: const Duration(milliseconds: 1),
    ),
  );
  return dio;
}

void main() {
  test('GET retries transient 5xx then succeeds', () async {
    final adapter = _CountingAdapter([500, 500, 200]);
    final dio = _dioWith(adapter);

    final res = await dio.get<dynamic>('endpoint');

    expect(res.statusCode, 200);
    expect(adapter.calls, 3); // 2 retries + final success
  });

  test('GET gives up after maxRetries', () async {
    final adapter = _CountingAdapter([500]);
    final dio = _dioWith(adapter);

    await expectLater(
      dio.get<dynamic>('endpoint'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.calls, 4); // initial + 3 retries
  });

  test('POST is not retried (non-idempotent)', () async {
    final adapter = _CountingAdapter([500, 200]);
    final dio = _dioWith(adapter);

    await expectLater(
      dio.post<dynamic>('endpoint'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.calls, 1); // no retry for POST
  });
}
