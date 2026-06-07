import 'package:dio/dio.dart';

import 'api_config.dart';
import 'auth_token_provider.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';
import 'network_exception_mapper.dart';

/// Backend-agnostic HTTP abstraction.
///
/// Data sources depend on this interface, never on Dio directly, so the
/// transport is interchangeable (e.g. swap Supabase REST for another backend)
/// and trivially mockable in tests. Every method throws a domain `Failure`
/// (mapped by [mapDioError]) on error.
abstract class ApiClient {
  Future<List<dynamic>> getList(String path, {Map<String, dynamic>? query});
  Future<dynamic> post(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
  });
  Future<dynamic> patch(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
  });
  Future<void> delete(String path, {Map<String, dynamic>? query});
}

/// [ApiClient] backed by Dio against the Supabase PostgREST endpoint.
class DioApiClient implements ApiClient {
  DioApiClient._(this._dio);

  final Dio _dio;

  factory DioApiClient({required AuthTokenProvider tokenProvider, Dio? dio}) {
    final client =
        dio ??
        Dio(
          BaseOptions(
            baseUrl: ApiConfig.restBaseUrl,
            connectTimeout: ApiConfig.connectTimeout,
            receiveTimeout: ApiConfig.receiveTimeout,
            headers: const {'Content-Type': 'application/json'},
          ),
        );
    client.interceptors.addAll([
      AuthInterceptor(tokenProvider),
      RetryInterceptor(client, maxRetries: ApiConfig.maxRetries),
      LoggingInterceptor(),
    ]);
    return DioApiClient._(client);
  }

  @override
  Future<List<dynamic>> getList(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await _dio.get<dynamic>(path, queryParameters: query);
      final data = res.data;
      return data is List ? data : const <dynamic>[];
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        path,
        data: body,
        queryParameters: query,
      );
      return res.data;
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    Object? body,
    Map<String, dynamic>? query,
  }) async {
    try {
      final res = await _dio.patch<dynamic>(
        path,
        data: body,
        queryParameters: query,
      );
      return res.data;
    } catch (e) {
      throw mapDioError(e);
    }
  }

  @override
  Future<void> delete(String path, {Map<String, dynamic>? query}) async {
    try {
      await _dio.delete<dynamic>(path, queryParameters: query);
    } catch (e) {
      throw mapDioError(e);
    }
  }
}
