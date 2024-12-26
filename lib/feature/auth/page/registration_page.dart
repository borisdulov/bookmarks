import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/core/theme/app_theme_constants.dart';
import 'package:firebase_auth_ex/feature/auth/cubit/auth_builder.dart';
import 'package:firebase_auth_ex/feature/auth/page/login_page.dart';
import 'package:firebase_auth_ex/feature/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

/// Страница регистрации нового аккаунта
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  static const String path = '/registration';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //* Контроллеры всех полей
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //* Не видно ли пароль
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(builder: (context, state) {
      return Scaffold(
        //* Стэк чтобы индикатор загрузки норм отобразить вверху
        body: Stack(children: [
          //* Контейнер чтобы картинку на бг поставить
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
                color: context.colorScheme.surface,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.m),
                ),
                child: Container(
                  width: 400,
                  padding: const EdgeInsets.all(AppPadding.l),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //* Поле email
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

                      const SizedBox(height: 8),

                      //* Поле пароль
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'password'.tr(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 8),

                      //* Поле подтверджения пароля
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: 'Confirm Password',
                        ),
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      //* Кнопка регистрации
                      FilledButton(
                        onPressed: () {
                          if (_validateInputs()) {
                            context.authCubit.signUp(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: Text('register'.tr()),
                      ),

                      const SizedBox(height: 24),

                      //* Кнопка Вход через гугл
                      OutlinedButton.icon(
                        onPressed: () {
                          context.authCubit.signInWithGoogle();
                        },
                        icon: SvgPicture.asset('assets/google.svg',
                            width: 24, height: 24),
                        label: const Text('Continue with Google'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          minimumSize: const Size.fromHeight(56),
                        ),
                      ),

                      const SizedBox(height: 16),

                      //* Ряд с дополнительными вариантами
                      Row(
                        children: [
                          //* Вход в существующий аккаунт
                          Expanded(
                            child: TextButton(
                              onPressed: () => context.go(LoginPage.path),
                              child: Text('logIn'.tr()),
                            ),
                          ),
                          //* Вертикальный разделитель
                          const SizedBox(
                            height: 16,
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
        ]),
      );
    });
  }

  bool _validateInputs() {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (email.isEmpty) {
      context.showSnackBar('Please, enter an email');

      return false;
    }

    if (password.isEmpty) {
      context.showSnackBar('Please, enter a password');

      return false;
    }

    if (password.length < 6) {
      context.showSnackBar('Passwords must be at least 6 characters');
      return false;
    }

    if (password != confirmPassword) {
      context.showSnackBar('Passwords do not match');
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose(); // Dispose new controller
    super.dispose();
  }
}
