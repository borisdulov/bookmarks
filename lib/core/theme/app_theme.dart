import 'package:firebase_auth_ex/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';

abstract final class AppLightColors {
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryContainer = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF7E3FFF);
  static const Color secondaryContainer = Color(0xFF5600E8);
  static const Color surface = Colors.white;
  static const Color surfaceContainer = Color.fromARGB(255, 240, 240, 240);
  static const Color error = Color(0xFFB00020);
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.black;
  static const Color onSurface = Colors.black;
  static const Color onError = Colors.white;
}

abstract final class AppDarkColors {
  static const Color primary = Color.fromARGB(255, 198, 154, 253);
  static const Color primaryContainer = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF9F6FFF);
  static const Color secondaryContainer = Color(0xFF7A30FF);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color surfaceContainer = Color(0xFF2C2C2C);
  static const Color error = Color(0xFFCF6679);
  static const Color onPrimary = Colors.black;
  static const Color onSecondary = Colors.black;
  static const Color onSurface = Colors.white;
  static const Color onError = Colors.black;
}

abstract final class AppColorScheme {
  static const ColorScheme light = ColorScheme.light(
    primary: AppLightColors.primary,
    primaryContainer: AppLightColors.primaryContainer,
    secondary: Color.fromARGB(255, 148, 95, 254),
    secondaryContainer: AppLightColors.secondaryContainer,
    surface: AppLightColors.surface,
    surfaceContainer: AppLightColors.surfaceContainer, // Добавлен новый цвет
    error: AppLightColors.error,
    onPrimary: AppLightColors.onPrimary,
    onSecondary: AppLightColors.onSecondary,
    onSurface: AppLightColors.onSurface,
    onError: AppLightColors.onError,
    brightness: Brightness.light,
  );

  static const ColorScheme dark = ColorScheme.dark(
    primary: AppDarkColors.primary,
    primaryContainer: AppDarkColors.primaryContainer,
    secondary: AppDarkColors.secondary,
    secondaryContainer: AppDarkColors.secondaryContainer,
    surface: AppDarkColors.surface,
    surfaceContainer: AppDarkColors.surfaceContainer, // Добавлен новый цвет
    error: AppDarkColors.error,
    onPrimary: AppDarkColors.onPrimary,
    onSecondary: AppDarkColors.onSecondary,
    onSurface: AppDarkColors.onSurface,
    onError: AppDarkColors.onError,
    brightness: Brightness.dark,
  );
}

abstract final class AppTheme {
  static ThemeData get lightTheme => _createTheme(AppColorScheme.light);
  static ThemeData get darkTheme =>
      _createTheme(AppColorScheme.dark); // Исправлена опечатка

  static ThemeData _createTheme(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        linearMinHeight: 8,
        color: colorScheme.primary,
        linearTrackColor: colorScheme.secondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: colorScheme.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.s),
        ),
      ),
      cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.s),
          ),
          color: colorScheme.surfaceContainer,
          margin: const EdgeInsets.all(0)),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: colorScheme.surface,
        labelColor: colorScheme.surface,
        dividerColor: colorScheme.primary,
        indicatorColor: colorScheme.surface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
