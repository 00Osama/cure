import 'package:cure/core/di/injection.dart';
import 'package:cure/core/them_and_locals/app_theme.dart';
import 'package:cure/core/them_and_locals/locals_cubit.dart';
import 'package:cure/core/them_and_locals/them_cubit.dart';
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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize Supabase
  await Supabase.initialize(
    url: '--',
    anonKey: '--',
  );
  
  // Initialize dependency injection
  await di.initialize();
  
  // main app entry with theme, locals features provider
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(settingsBox: settingsBox)
            ..loadThemePreference(),
        ),
        BlocProvider(
          create: (_) => LanguageCubit(settingsBox: settingsBox)
            ..loadLanguagePreference(),
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
              home: const Scaffold(
                body: Center(
                  child: Text('CURE - Home Care Nursing'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}