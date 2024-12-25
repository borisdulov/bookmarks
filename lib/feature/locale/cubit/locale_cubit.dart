import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth_ex/core/exception/app_exception_handler.dart';
import 'package:firebase_auth_ex/core/router/app_router_key.dart';
import 'package:firebase_auth_ex/core/service/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Список поддерживаемых языков
const List<Locale> supportedLanguages = [
  Locale('en'),
  Locale('ru'),
];

const Locale defaultLocale = Locale('en');

class LocaleCubit extends Cubit<Locale> {
  final LocalStorageService _localStorageService;
  static const String _languageKey = 'current_language';

  LocaleCubit({required LocalStorageService localStorageService})
      : _localStorageService = localStorageService,
        super(const Locale('en')) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final savedLanguageCode =
          await _localStorageService.getString(_languageKey);

      if (savedLanguageCode != null) {
        final savedLocale = supportedLanguages.firstWhere(
            (locale) => locale.languageCode == savedLanguageCode,
            orElse: () => defaultLocale);

        emit(savedLocale);
      }
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
    }
  }

  // Переключение на следующий язык
  void switchToNextLanguage() {
    final currentIndex = supportedLanguages.indexOf(state);
    final nextIndex = (currentIndex + 1) % supportedLanguages.length;
    final nextLocale = supportedLanguages[nextIndex];

    AppRouterKey.rootKey.currentContext!.setLocale(nextLocale);

    _saveLanguage(nextLocale);

    emit(nextLocale);
  }

  void setLanguage(BuildContext context, Locale locale) {
    if (supportedLanguages.contains(locale)) {
      context.setLocale(locale);

      _saveLanguage(locale);

      emit(locale);
    }
  }

  Future<void> _saveLanguage(Locale locale) async {
    try {
      await _localStorageService.saveString(_languageKey, locale.languageCode);
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
    }
  }
}
