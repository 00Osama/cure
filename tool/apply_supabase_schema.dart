// Applies docs/supabase_schema.sql to a Supabase project via the Management
// API. No external packages (uses dart:io HttpClient).
//
// Usage:
//   dart run tool/apply_supabase_schema.dart <SUPABASE_ACCESS_TOKEN> [sqlFile] [projectRef]
//
// Get a token at: https://supabase.com/dashboard/account/tokens
// sqlFile defaults to docs/supabase_schema.sql; projectRef defaults to this app's project.
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    stderr.writeln(
      'Usage: dart run tool/apply_supabase_schema.dart '
      '<SUPABASE_ACCESS_TOKEN> [sqlFile] [projectRef]',
    );
    exit(64);
  }

  final token = args[0];
  final sqlFile = args.length > 1 ? args[1] : 'docs/supabase_schema.sql';
  final ref = args.length > 2 ? args[2] : 'wrzvjdmcylevmohoaqmv';
  final sql = await File(sqlFile).readAsString();

  final client = HttpClient();
  try {
    final request = await client.postUrl(
      Uri.parse('https://api.supabase.com/v1/projects/$ref/database/query'),
    );
    request.headers.set('Authorization', 'Bearer $token');
    request.headers.contentType = ContentType.json;
    request.add(utf8.encode(jsonEncode({'query': sql})));

    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();
    stdout.writeln('HTTP ${response.statusCode}');
    stdout.writeln(body.isEmpty ? '(empty body)' : body);
    if (response.statusCode >= 400) exit(1);
    stdout.writeln('\n✅ Schema applied. Hot-restart the app.');
  } finally {
    client.close();
  }
}
