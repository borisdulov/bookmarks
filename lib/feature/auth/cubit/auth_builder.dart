import 'package:firebase_auth_ex/feature/auth/cubit/auth_cubit.dart';
import 'package:firebase_auth_ex/feature/auth/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBuilder extends StatelessWidget {
  final BlocWidgetBuilder<AuthState> builder;

  const AuthBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: builder);
  }
}
