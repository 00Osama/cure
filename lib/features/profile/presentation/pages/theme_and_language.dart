import 'package:cure/features/profile/presentation/widgets/lang_and_theme_cards.dart';
import 'package:cure/generated/l10n.dart';
import 'package:cure/shared/theme_and_locals/locals_cubit.dart';
import 'package:cure/shared/theme_and_locals/them_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageAndThemePage extends StatefulWidget {
  const LanguageAndThemePage({super.key});

  @override
  State<LanguageAndThemePage> createState() => _LanguageAndThemePageState();
}

class _LanguageAndThemePageState extends State<LanguageAndThemePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isTablet = screenWidth >= 600;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).languageAndTheme,
          style: TextStyle(fontSize: isTablet ? 45 : 23),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          /// Theme Section
          Text(
            S.of(context).themeMode,
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 10),

          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: ThemeCard(
                      title: S.of(context).darkMode,
                      icon: state == ThemeState.dark
                          ? Icons.done_rounded
                          : Icons.dark_mode_outlined,
                      selected: state == ThemeState.dark,
                      color: Colors.deepPurple,
                      onTap: () {
                        context.read<ThemeCubit>().setThemeMode(
                          ThemeState.dark,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ThemeCard(
                      title: S.of(context).lightMode,
                      icon: state == ThemeState.light
                          ? Icons.done_rounded
                          : Icons.light_mode_outlined,
                      selected: state == ThemeState.light,
                      color: Colors.orange,
                      onTap: () {
                        context.read<ThemeCubit>().setThemeMode(
                          ThemeState.light,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 40),

          /// Language Section
          Text(
            S.of(context).language,
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 10),

          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  children: [
                    Expanded(
                      child: LanguageCard(
                        title: S.of(context).english,
                        icon: '🇺🇸',
                        selected: state == LanguageState.english,
                        color: Colors.blue,
                        onTap: () {
                          context.read<LanguageCubit>().setLanguage(
                            LanguageState.english,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: LanguageCard(
                        title: S.of(context).arabic,
                        icon: '🇸🇦',
                        selected: state == LanguageState.arabic,
                        color: Colors.green,
                        onTap: () {
                          context.read<LanguageCubit>().setLanguage(
                            LanguageState.arabic,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
