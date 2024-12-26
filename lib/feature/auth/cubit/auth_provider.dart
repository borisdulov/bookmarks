import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/feature/auth/cubit/auth_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthProvider extends BlocProvider<AuthCubit> {
  AuthProvider({super.key})
      : super(
            create: (context) => AuthCubit(
                firebaseAuth: context.appConfig.state.authInstance,
                googleSignIn: context.appConfig.state.googleSignIn));
}
