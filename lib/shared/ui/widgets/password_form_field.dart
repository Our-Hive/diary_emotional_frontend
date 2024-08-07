import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final String label;
  final void Function(String) onChangedCallBack;
  const PasswordFormField({
    super.key,
    this.label = 'Contraseña',
    required this.onChangedCallBack,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: _showPassword ? false : true,
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        labelText: widget.label,
        suffixIcon: IconButton(
          onPressed: () => setState(() => _showPassword = !_showPassword),
          icon: Icon(_showPassword
              ? Icons.visibility_rounded
              : Icons.visibility_off_rounded),
        ),
      ),
      onChanged: widget.onChangedCallBack,
    );
  }
}
