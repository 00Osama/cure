class ApiConfig {
  ApiConfig._();

  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://wrzvjdmcylevmohoaqmv.supabase.co',
  );
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndyenZqZG1jeWxldm1vaG9hcW12Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc4MDM0MzU1NywiZXhwIjoyMDk1OTE5NTU3fQ.5nYbqIIgh3fN5vCl6Z84clFsnf6PJq55RaYX8yvyoXs',
  );

  static String get restBaseUrl => '$supabaseUrl/rest/v1/';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);

  static const String apiKeyHeader = 'apikey';
  static const int maxRetries = 3;

  static bool get hasAnonKey => supabaseAnonKey.isNotEmpty;
}
