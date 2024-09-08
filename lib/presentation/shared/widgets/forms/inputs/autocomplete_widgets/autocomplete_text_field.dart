import 'package:flutter/material.dart';

class AutoCompleteTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final IconData? icon;
  final Function(String)? onChanged;

  const AutoCompleteTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.focusNode,
    this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        suffixIcon: icon != null ? Icon(icon) : null,
      ),
      controller: textEditingController,
      focusNode: focusNode,
      onChanged: onChanged,
    );
  }
}
