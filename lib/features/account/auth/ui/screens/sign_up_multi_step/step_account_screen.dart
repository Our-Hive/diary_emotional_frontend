import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/account/auth/ui/provider/signup_form_provider.dart';
import 'package:emotional_app/shared/ui/password_form_field.dart';
import 'package:emotional_app/features/account/auth/ui/widgets/to_login_text_button.dart';
import 'package:emotional_app/shared/ui/widgets/our_hive_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpStepAccountScreen extends StatelessWidget {
  const SignUpStepAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurHiveAppBar(
        title: 'Registro',
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _SignUpAccountForm(),
                Divider(
                  height: 50,
                  thickness: 2,
                ),
                ToLoginTextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpAccountForm extends ConsumerWidget {
  const _SignUpAccountForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme appColors = Theme.of(context).colorScheme;

    ref.listen(
      signUpFormProvider,
      (previous, next) {
        if (next.state == SignUpState.success &&
            next.currentStep == SignUpStep.contactStep) {
          context.pushNamed(AppRoutesName.signUpContact);
        }
        if (next.state == SignUpState.failure && next.errorMessage.isNotEmpty) {
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
      },
    );

    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.text,
            onChanged: (value) =>
                ref.watch(signUpFormProvider.notifier).onNickNameChanged(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.alternate_email_sharp),
              labelText: 'Nickname',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                ref.watch(signUpFormProvider.notifier).onEmailChanged(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.mail),
              labelText: 'Correo Electrónico',
            ),
          ),
          const SizedBox(height: 20),
          PasswordFormField(
            onChangedCallBack: (value) =>
                ref.watch(signUpFormProvider.notifier).onPasswordChanged(value),
          ),
          const SizedBox(height: 20),
          PasswordFormField(
            label: 'Confirmar Contraseña',
            onChangedCallBack: (value) => ref
                .watch(signUpFormProvider.notifier)
                .onConfirmPasswordChanged(value),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () =>
                ref.watch(signUpFormProvider.notifier).onSummitAccountStep(),
            child: const Text('Siguiente Paso'),
          ),
        ],
      ),
    );
  }
}
