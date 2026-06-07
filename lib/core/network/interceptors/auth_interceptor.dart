import 'package:dio/dio.dart';

import '../api_config.dart';
import '../auth_token_provider.dart';

/// Injects PostgREST auth headers on every request: the `apikey` header, a
/// `Bearer` token from [AuthTokenProvider], and a default
/// `Prefer: return=representation` so writes return the affected rows.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenProvider);

  final AuthTokenProvider _tokenProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers[ApiConfig.apiKeyHeader] = _tokenProvider.apiKey;
    final token = await _tokenProvider.bearerToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers.putIfAbsent('Prefer', () => 'return=representation');
    handler.next(options);
  }
}
