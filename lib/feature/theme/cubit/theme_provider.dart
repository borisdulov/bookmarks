import 'package:firebase_auth_ex/feature/theme/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeProvider extends BlocProvider<ThemeCubit> {
  ThemeProvider({super.key}) : super(create: (_) => ThemeCubit());
}
