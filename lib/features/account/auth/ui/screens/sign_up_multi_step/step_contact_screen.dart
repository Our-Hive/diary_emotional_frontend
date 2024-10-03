import 'package:emotional_app/config/router/app_routes_name.dart';
import 'package:emotional_app/features/account/auth/domain/entities/sign_up_credentials.dart';
import 'package:emotional_app/features/account/auth/ui/provider/auth_provider.dart';
import 'package:emotional_app/features/account/auth/ui/provider/signup_form_provider.dart';
import 'package:emotional_app/features/account/auth/ui/widgets/date_field.dart';
import 'package:emotional_app/features/account/auth/ui/widgets/to_login_text_button.dart';
import 'package:emotional_app/shared/ui/widgets/our_hive_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpStepContactScreen extends StatelessWidget {
  const SignUpStepContactScreen({super.key});

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
                _SignUpContactForm(),
                Divider(
                  height: 50,
                  thickness: 2,
                ),
                ToLoginTextButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpContactForm extends ConsumerWidget {
  const _SignUpContactForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme appColors = Theme.of(context).colorScheme;

    ref.listen(authProvider, (_, next) {
      if (next.authStatus == AuthStatus.authenticated) {
        context.goNamed(AppRoutesName.homeView);
      }
      if (next.error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.error,
              style: TextStyle(
                color: appColors.onError,
              ),
            ),
            backgroundColor: appColors.error,
          ),
        );
      }
    });

    ref.listen(
      signUpFormProvider,
      (_, next) {
        if (next.state == SignUpState.success &&
            next.currentStep == SignUpStep.summitStep) {
          ref.watch(authProvider.notifier).signUp(
                SignUpCredentials(
                  birthDate: next.birthDate!,
                  email: next.email,
                  firstName: next.firstName,
                  lastName: next.lastName,
                  password: next.password,
                  phoneNumber: next.phoneNumber,
                  username: next.nickName,
                ),
              );
        }
        if (next.state == SignUpState.failure && next.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  next.errorMessage,
                  style: TextStyle(
                    color: appColors.onError,
                  ),
                ),
                backgroundColor: appColors.error,
              ),
            );
        }
      },
    );

    return Form(
      child: Column(
        children: [
          const _OurHiveSignUpText(),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.name,
            onChanged: (value) => ref
                .watch(signUpFormProvider.notifier)
                .onFirstNameChanged(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: 'Nombre',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.name,
            onChanged: (value) =>
                ref.watch(signUpFormProvider.notifier).onLastNameChanged(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              labelText: 'Apellido',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.phone,
            onChanged: (value) => ref
                .watch(signUpFormProvider.notifier)
                .onPhoneNumberChanged(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone),
              labelText: 'Teléfono',
            ),
          ),
          const SizedBox(height: 20),
          const DateField(),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () =>
                ref.watch(signUpFormProvider.notifier).onSummitContactStep(),
            child: const Text('Regístrate'),
          ),
        ],
      ),
    );
  }
}

class _OurHiveSignUpText extends StatelessWidget {
  const _OurHiveSignUpText();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text: 'Para',
            ),
            TextSpan(
              text: '\rOur Hive\r',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
            ),
            TextSpan(
              text:
                  'es importante conocerte mejor, que tal si llenas los siguientes campos :D',
            )
          ],
        ),
      ),
    );
  }
}
