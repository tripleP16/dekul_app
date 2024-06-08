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
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;

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
    this.prefixIcon,
    this.onTap,
    this.readOnly = false,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      obscureText: obscureText,
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
          labelStyle: theme.textTheme.bodyLarge,
          hintStyle: theme.textTheme.bodyLarge,
          labelText: labelText,
          errorText: errorText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          errorStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.red)),
      validator: validator,
    );
  }
}
