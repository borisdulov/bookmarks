import 'package:firebase_auth_ex/core/config/config.dart';
import 'package:firebase_auth_ex/feature/auth/cubit/auth_cubit.dart';
import 'package:firebase_auth_ex/feature/bookmark/cubit/bookmark_cubit.dart';
import 'package:firebase_auth_ex/feature/locale/cubit/locale_cubit.dart';
import 'package:firebase_auth_ex/feature/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextExtension on BuildContext {
  // Кубиты
  ThemeCubit get themeCubit => BlocProvider.of<ThemeCubit>(this);
  AuthCubit get authCubit => BlocProvider.of<AuthCubit>(this);
  AppConfigCubit get appConfig => BlocProvider.of<AppConfigCubit>(this);
  BookmarkCubit get bookmarkListCubit => BlocProvider.of<BookmarkCubit>(this);
  LocaleCubit get localeCubit => BlocProvider.of<LocaleCubit>(this);

  // Тема
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }
}
