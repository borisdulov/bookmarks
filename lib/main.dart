import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth_ex/core/config/config.dart';
import 'package:firebase_auth_ex/core/router/app_router.dart';
import 'package:firebase_auth_ex/core/theme/app_theme.dart';
import 'package:firebase_auth_ex/feature/auth/cubit/auth_provider.dart';
import 'package:firebase_auth_ex/feature/locale/cubit/locale_provider.dart';
import 'package:firebase_auth_ex/feature/theme/cubit/theme_builder.dart';
import 'package:firebase_auth_ex/feature/theme/cubit/theme_provider.dart';
import 'package:firebase_auth_ex/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const _MyApp(),
    ),
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          AppConfigProvider(),
          AuthProvider(),
          ThemeProvider(),
          LocaleProvider()
        ],
        child: ThemeBuilder(builder: (context, state) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state,
          );
        }));
  }
}
