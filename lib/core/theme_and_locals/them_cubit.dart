import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum ThemeState { system, light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  final Box settingsBox;

  ThemeCubit({required this.settingsBox}) : super(ThemeState.system);

  void setThemeMode(ThemeState themeState) {
    emit(themeState);
    settingsBox.put('themeMode', themeState.toString());
  }

  void loadThemePreference() {
    String? storedTheme = settingsBox.get('themeMode');
    if (storedTheme == 'ThemeState.dark') {
      emit(ThemeState.dark);
    } else if (storedTheme == 'ThemeState.light') {
      emit(ThemeState.light);
    } else {
      emit(ThemeState.system);
    }
  }

  ThemeMode get themeMode {
    switch (state) {
      case ThemeState.light:
        return ThemeMode.light;
      case ThemeState.dark:
        return ThemeMode.dark;
      case ThemeState.system:
        return ThemeMode.system;
    }
  }
}
