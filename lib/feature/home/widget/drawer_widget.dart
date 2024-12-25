import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth_ex/core/extension/build_context_extension.dart';
import 'package:firebase_auth_ex/feature/auth/cubit/auth_state.dart';
import 'package:firebase_auth_ex/feature/auth/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.authCubit.state;
    final isLoggedIn = authState is AuthStateAuthenticated;

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Account Card
            Card.filled(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.account_circle_rounded,
                          size: 80,
                        ),
                        Text(
                          isLoggedIn ? authState.name : 'guest'.tr(),
                          style: context.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (isLoggedIn) {
                        return ListTile(
                          leading: const Icon(Icons.logout_rounded),
                          title: Text('logout'.tr()),
                          onTap: () => context.authCubit.logOut(),
                        );
                      } else {
                        return ListTile(
                          leading: const Icon(Icons.login_rounded),
                          title: Text('login'.tr()),
                          onTap: () => context.go(LoginPage.path),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Settings Card
            Card.filled(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.color_lens),
                    title: Text('theme'.tr()),
                    onTap: () => context.themeCubit.toggleTheme(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text('language'.tr()),
                    onTap: () {
                      context.localeCubit.switchToNextLanguage();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
