import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/feature/locale/cubit/locale_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleProvider extends BlocProvider<LocaleCubit> {
  LocaleProvider({super.key})
      : super(
            create: (context) => LocaleCubit(
                localStorageService:
                    context.appConfig.state.localStorageService));
}
