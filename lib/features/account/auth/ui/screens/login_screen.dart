import 'package:animate_do/animate_do.dart';
import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/account/auth/ui/provider/auth_provider.dart';
import 'package:emotional_app/features/account/auth/ui/provider/login_form_provider.dart';
import 'package:emotional_app/shared/ui/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme appColors = Theme.of(context).colorScheme;

    ref.listen(loginFormProvider, (previous, next) {
      if (next.isFailure && next.errorMessage.isNotEmpty && next.isSubmitting) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: appColors.error,
              content: Text(
                next.errorMessage,
                style: TextStyle(
                  color: appColors.onError,
                ),
              ),
            ),
          );
      }
    });

    ref.listen(authProvider, (previous, next) {
      if (next.error.isNotEmpty) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: appColors.error,
              content: Text(
                next.error,
                style: TextStyle(
                  color: appColors.onError,
                ),
              ),
            ),
          );
      }
      if (next.authStatus == AuthStatus.authenticated) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Future.delayed(
          const Duration(milliseconds: 500),
          () => context.goNamed(AppRoutesName.homeView),
        );
      }
    });

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ZoomIn(
                    animate: true,
                    duration: const Duration(seconds: 1),
                    child: FadeOutUp(
                      animate: ref.watch(authProvider).authStatus ==
                          AuthStatus.authenticated,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        child: Image.asset(
                          'assets/app_image_yellow.webp',
                        ),
                      ),
                    ),
                  ),
                  const _LoginForm(),
                  const Divider(
                    height: 50,
                    thickness: 2,
                  ),
                  TextButton(
                    onPressed: () => context.goNamed(
                      AppRoutesName.signUpAccount,
                    ),
                    child: const Column(
                      children: <Text>[
                        Text('¿No puedes iniciar sesión?'),
                        Text('Crear Cuenta'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.mail),
              labelText: 'Correo Electrónico',
            ),
            onChanged: (value) => ref
                .watch(loginFormProvider.notifier)
                .onEmailChanged(value.trim().toLowerCase()),
          ),
          const SizedBox(height: 20),
          PasswordFormField(
            onChangedCallBack: (value) => ref
                .watch(loginFormProvider.notifier)
                .onPasswordChanged(value.trim().toLowerCase()),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              final isValidated =
                  ref.watch(loginFormProvider.notifier).onSubmit();
              if (isValidated) {
                final loginFormData = ref.watch(loginFormProvider);
                ref
                    .watch(authProvider.notifier)
                    .login(loginFormData.email, loginFormData.password);
              }
            },
            child: const Text('Inicio de Sesión'),
          ),
        ],
      ),
    );
  }
}
