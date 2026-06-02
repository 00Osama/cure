import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum LanguageState { english, arabic, french }

class LanguageCubit extends Cubit<LanguageState> {
  final Box settingsBox;
  
  LanguageCubit({required this.settingsBox}) : super(LanguageState.english);

  void setLanguage(LanguageState languageState) {
    emit(languageState);
    settingsBox.put('language', languageState.toString());
  }

  void loadLanguagePreference() {
    final storedLanguage = settingsBox.get('language');
    if (storedLanguage != null) {
      if (storedLanguage == 'LanguageState.arabic') {
        emit(LanguageState.arabic);
      } else if (storedLanguage == 'LanguageState.french') {
        emit(LanguageState.french);
      } else {
        emit(LanguageState.english);
      }
    } else {
      emit(LanguageState.english);
    }
  }

  Locale get locale {
    switch (state) {
      case LanguageState.arabic:
        return const Locale('ar');
      case LanguageState.french:
        return const Locale('fr');
      case LanguageState.english:
        return const Locale('en');
    }
  }
}