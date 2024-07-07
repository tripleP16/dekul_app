import 'package:flutter/material.dart';

class ForgotPasswordBodyViewModel {
  final String labelText;
  final void Function(String) onChanged;
  final String? errorText;
  final Widget textWidget;
  final String buttonLabel;
  final void Function()? onPressed;
  final String? initialValue;

  const ForgotPasswordBodyViewModel({
    required this.labelText,
    required this.onChanged,
    required this.errorText,
    required this.textWidget,
    required this.buttonLabel,
    required this.onPressed,
    required this.initialValue,
  });
}
