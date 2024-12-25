import 'package:firebase_auth_ex/core/router/app_router_guards.dart';
import 'package:firebase_auth_ex/core/router/app_router_key.dart';
import 'package:firebase_auth_ex/feature/auth/page/login_page.dart';
import 'package:firebase_auth_ex/feature/auth/page/registration_page.dart';
import 'package:firebase_auth_ex/feature/bookmark/cubit/bookmark_provider.dart';
import 'package:firebase_auth_ex/feature/home/page/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    navigatorKey: AppRouterKey.rootKey,
    initialLocation: HomePage.path,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        navigatorKey: AppRouterKey.authenticatedKey,
        builder: (context, state, child) => MultiBlocProvider(
            providers: [BookmarkProvider.create(context)], child: child),
        routes: [
          GoRoute(
            path: HomePage.path,
            builder: (context, state) => const HomePage(),
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) => child,
        redirect: AppRouterGuards.auth,
        routes: [
          GoRoute(
            path: LoginPage.path,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: RegistrationPage.path,
            builder: (context, state) => const RegistrationPage(),
          ),
        ],
      )
    ],
  );
}
