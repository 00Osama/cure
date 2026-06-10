import 'package:cure/core/network/api_config.dart';
import 'package:cure/features/auth/presentation/pages/splash_page.dart';
import 'package:cure/core/di/injection.dart';
import 'package:cure/core/theme_and_locals/app_theme.dart';
import 'package:cure/core/theme_and_locals/locals_cubit.dart';
import 'package:cure/core/theme_and_locals/them_cubit.dart';
import 'package:cure/firebase_options.dart';
import 'package:cure/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open Hive box for settings
  final settingsBox = await Hive.openBox('settings');

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Supabase using the anon key supplied via --dart-define
  // (never hardcode a privileged key in the client — see README "Security").
  if (ApiConfig.hasAnonKey) {
    await Supabase.initialize(
      url: ApiConfig.supabaseUrl,
      anonKey: ApiConfig.supabaseAnonKey,
    );
  } else {
    debugPrint(
      '⚠️  SUPABASE_ANON_KEY is not set. Pass it via '
      '--dart-define-file=dart_define.dev.json. '
      'Supabase-backed features (booking, image upload) are disabled.',
    );
  }

  // Initialize dependency injection
  await di.initialize();

  // Initialize push notifications (best-effort; unsupported on desktop).
  try {
    await di.notificationService.initialize();
  } catch (e) {
    debugPrint('Notification init skipped: $e');
  }

  // main app entry with theme, locals features provider
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ThemeCubit(settingsBox: settingsBox)..loadThemePreference(),
        ),
        BlocProvider(
          create: (_) =>
              LanguageCubit(settingsBox: settingsBox)..loadLanguagePreference(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, langState) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: context.watch<LanguageCubit>().locale,
              theme: AppTheme.lightTheme(context),
              darkTheme: AppTheme.darkTheme(context),
              themeMode: context.watch<ThemeCubit>().themeMode,
              home: const SplashPage(),
            );
          },
        );
      },
    );
  }
}
