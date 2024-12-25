import 'dart:async';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/feature/auth/cubit/auth_state.dart';
import 'package:firebase_auth_ex/feature/home/page/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouterGuards {
  static FutureOr<String?> auth(BuildContext context, GoRouterState state) {
    final authState = context.authCubit.state;

    if (authState is AuthStateAuthenticated) {
      return HomePage.path;
    }

    return null;
  }

  //? Гвард для авторизованных маршрутов
  // static FutureOr<String?> auth(
  //     BuildContext context, GoRouterState state) {
  //   final authState = context.read<AuthCubit>().state;

  //   if (authState is AuthCubitUnauthenticated) {
  //     return SignInPage.path;
  //   }

  //   return null;
  // }

  //? Гвард для публичных маршрутов
  static FutureOr<String?> public(BuildContext context, GoRouterState state) {
    return null;
  }
}
