import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/core/theme/app_theme_constants.dart';
import 'package:firebase_auth_ex/feature/auth/cubit/auth_builder.dart';
import 'package:firebase_auth_ex/feature/auth/page/registration_page.dart';
import 'package:firebase_auth_ex/feature/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

/// Страница входа в аккаунт
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String path = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //* Не видно ли пароль
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(builder: (context, state) {
      return Scaffold(
        //* Стэк чтобы индикатор загрузки норм отобразить вверху
        body: Stack(
          //* Картинка на бг
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.3,
                ),
              ),
              child: Center(
                //* Основная карточка
                child: Card(
                  margin: const EdgeInsets.all(AppPadding.m),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: context.colorScheme.surface,
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(AppPadding.l),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //* Поле почты
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'email'.tr(),
                            filled: true,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppPadding.s),

                        //* Поле пароля
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'password'.tr(),
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscureText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppPadding.m),

                        //* Кнопка входа
                        FilledButton(
                          onPressed: () {
                            context.authCubit.signIn(
                                email: emailController.text,
                                password: passwordController.text);
                          },
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.xs),
                            ),
                            minimumSize: const Size.fromHeight(56),
                          ),
                          child: Text('logIn'.tr()),
                        ),

                        const SizedBox(height: AppPadding.l),

                        //* Войти через гугл
                        const SignInWithGoogleButton(),

                        const SizedBox(height: AppPadding.l),

                        //* Ряд с дополнительными действиями
                        Row(
                          children: [
                            //* Создать аккаунт
                            Expanded(
                              child: TextButton(
                                onPressed: () =>
                                    context.go(RegistrationPage.path),
                                child: Text('createAccount'.tr()),
                              ),
                            ),
                            //* Вертикальный разделитель
                            const SizedBox(
                              height: AppPadding.m,
                              child: VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            //* Продолжить как гость (без входа)
                            Expanded(
                              child: TextButton(
                                onPressed: () => context.go(HomePage.path),
                                child: Text('continueAsGuest'.tr()),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //* Индикатор загрузки
            if (state.isLoading) const LinearProgressIndicator()
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        context.authCubit.signInWithGoogle();
      },
      icon: SvgPicture.asset('assets/google.svg', width: 24, height: 24),
      label: const Text('Continue with Google'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.m),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
        minimumSize: const Size.fromHeight(56),
      ),
    );
  }
}
