import 'package:firebase_auth/firebase_auth.dart';

abstract base class AuthState {
  bool get isAuth => this is AuthStateAuthenticated;
  bool get isLoading => this is AuthStateLoading;
}

final class AuthStateAuthenticated extends AuthState {
  final User user;
  String get name => user.email ?? user.displayName ?? user.uid;

  AuthStateAuthenticated({required this.user});
}

final class AuthStateUnauthenticated extends AuthState {
  final Object? error;

  AuthStateUnauthenticated({this.error});
}

final class AuthStateLoading extends AuthState {}
