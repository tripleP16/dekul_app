import 'package:flutter/material.dart';

class AutoCompleteTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  const AutoCompleteTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      controller: textEditingController,
      focusNode: focusNode,
    );
  }
}
