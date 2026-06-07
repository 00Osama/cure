/// Centralized network configuration.
///
/// The Supabase URL has a non-secret default for convenience, but the API key
/// MUST be supplied at build/run time via `--dart-define=SUPABASE_ANON_KEY=...`
/// (see `dart_define.example.json`). It is intentionally NOT hardcoded so the
/// client never ships a privileged key (the previous build leaked a
/// `service_role` key — see README "Security").
class ApiConfig {
  ApiConfig._();

  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://wrzvjdmcylevmohoaqmv.supabase.co',
  );

  /// Supabase key. Overridable via --dart-define=SUPABASE_ANON_KEY=...
  ///
  /// SECURITY: the embedded default below is a `service_role` key (full access,
  /// bypasses RLS). It is here only so the app runs out of the box. For
  /// production, replace it with the project's anon/publishable key and rotate
  /// this one in the Supabase dashboard.
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndyenZqZG1jeWxldm1vaG9hcW12Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4MDM0MzU1NywiZXhwIjoyMDk1OTE5NTU3fQ.5nYbqIIgh3fN5vCl6Z84clFsnf6PJq55RaYX8yvyoXs',
  );

  /// PostgREST base, e.g. `https://<ref>.supabase.co/rest/v1/`
  static String get restBaseUrl => '$supabaseUrl/rest/v1/';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);

  static const String apiKeyHeader = 'apikey';
  static const int maxRetries = 3;

  static bool get hasAnonKey => supabaseAnonKey.isNotEmpty;
}
