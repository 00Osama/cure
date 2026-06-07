import 'api_config.dart';

/// Supplies the credentials injected by `AuthInterceptor`.
///
/// This is the single swap-point for the Firebase↔Supabase auth bridge.
/// The default implementation authenticates PostgREST with the Supabase anon
/// key (per-user isolation enforced app-side). A future
/// `SupabaseSessionTokenProvider` can return a real per-user Supabase access
/// token to enable strict row-level security — without touching any data
/// source (see README "Auth bridge").
abstract class AuthTokenProvider {
  /// Value for the PostgREST `apikey` header.
  String get apiKey;

  /// Value for the `Authorization: Bearer <token>` header, or null to omit.
  Future<String?> bearerToken();
}

/// Default provider: anon key for both `apikey` and bearer token.
class SupabaseAnonTokenProvider implements AuthTokenProvider {
  const SupabaseAnonTokenProvider();

  @override
  String get apiKey => ApiConfig.supabaseAnonKey;

  @override
  Future<String?> bearerToken() async => ApiConfig.supabaseAnonKey;
}
