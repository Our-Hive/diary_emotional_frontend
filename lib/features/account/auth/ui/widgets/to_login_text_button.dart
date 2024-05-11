import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/account/auth/ui/provider/signup_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ToLoginTextButton extends ConsumerWidget {
  const ToLoginTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
        onPressed: () => {
              ref.watch(signUpFormProvider.notifier).cleanState(),
              context.go(AppRoutesName.logInScreen),
            },
        child: const Column(
          children: <Text>[
            Text('¿Ya tienes cuenta?'),
            Text('Inicia sesión'),
          ],
        ));
  }
}
