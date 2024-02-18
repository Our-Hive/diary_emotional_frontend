import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final String label;
  const PasswordFormField({super.key, this.label = 'Contraseña'});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        labelText: label,
        suffixIcon: IconButton(
          onPressed: () => print('show password'),
          icon: const Icon(Icons.visibility_off),
        ),
      ),
    );
  }
}
