import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ex/core/exception/app_exception_handler.dart';
import 'package:firebase_auth_ex/core/router/app_router_key.dart';
import 'package:firebase_auth_ex/feature/auth/cubit/auth_state.dart';
import 'package:firebase_auth_ex/feature/auth/page/login_page.dart';
import 'package:firebase_auth_ex/feature/home/page/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;
  late StreamSubscription<User?> _streamSubscription;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthCubit({
    required FirebaseAuth firebaseAuth,
  })  : _firebaseAuth = firebaseAuth,
        super(AuthStateLoading()) {
    _streamSubscription =
        _firebaseAuth.authStateChanges().listen(_onAuthStateChange);
  }

  void _onAuthStateChange(User? user) {
    if (user != null) {
      emit(AuthStateAuthenticated(user: user));
    } else {
      emit(AuthStateUnauthenticated());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthStateLoading());

    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AuthStateAuthenticated(user: result.user!));

      AppRouterKey.rootKey.currentContext?.go(HomePage.path);
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      emit(AuthStateUnauthenticated(error: e));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    emit(AuthStateLoading());

    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AuthStateAuthenticated(user: result.user!));

      AppRouterKey.rootKey.currentContext?.go(HomePage.path);
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      emit(AuthStateUnauthenticated(error: e));
    }
  }

  Future<void> logOut() async {
    emit(AuthStateLoading());

    try {
      await _firebaseAuth.signOut();

      AppRouterKey.rootKey.currentContext?.go(LoginPage.path);
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
    } finally {
      emit(AuthStateUnauthenticated());
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthStateLoading());

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthStateUnauthenticated());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result =
          await _firebaseAuth.signInWithCredential(credential);

      emit(AuthStateAuthenticated(user: result.user!));

      AppRouterKey.rootKey.currentContext?.go(HomePage.path);
    } catch (e, stackTrace) {
      AppExceptionHandler.handleException(e, stackTrace);
      emit(AuthStateUnauthenticated(error: e));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
