import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ex/core/service/local_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppConfigCubit extends Cubit<AppConfigState> {
  AppConfigCubit()
      : super(
          AppConfigState(
              googleSignIn: GoogleSignIn(),
              authInstance: FirebaseAuth.instance,
              firestoreInstance: FirebaseFirestore.instance,
              localStorageService: LocalStorageService(),
              dio: Dio(BaseOptions(
                connectTimeout: const Duration(seconds: 5),
                receiveTimeout: const Duration(seconds: 5),
                sendTimeout: const Duration(seconds: 5),
              ))),
        );
}

final class AppConfigState {
  final FirebaseAuth authInstance;
  final FirebaseFirestore firestoreInstance;
  final LocalStorageService localStorageService;
  final Dio dio;
  final GoogleSignIn googleSignIn;

  AppConfigState(
      {required this.authInstance,
      required this.firestoreInstance,
      required this.localStorageService,
      required this.dio,
      required this.googleSignIn});
}

class AppConfigProvider extends BlocProvider<AppConfigCubit> {
  AppConfigProvider({super.key}) : super(create: (_) => AppConfigCubit());
}
