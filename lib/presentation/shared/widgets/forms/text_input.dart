import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? hintText;
  final String? initialValue;
  final TextInputType keyboardType;
  final void Function(String) onChanged;

  const TextInputWidget({
    super.key,
    required this.labelText,
    this.errorText,
    this.validator,
    this.obscureText = false,
    this.hintText,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 18),
      decoration: InputDecoration(
          labelStyle: const TextStyle(fontSize: 18),
          hintStyle: const TextStyle(fontSize: 18),
          labelText: labelText,
          errorText: errorText,
          hintText: hintText,
          errorStyle:
              const TextStyle(color: AppColors.errorColor, fontSize: 16)),
      validator: validator,
    );
  }
}
