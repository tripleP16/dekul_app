import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final String labelText;
  final String? errorText;
  final double? borderRadius;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? hintText;
  final String? initialValue;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;

  const TextInputWidget({
    super.key,
    required this.labelText,
    this.borderRadius,
    this.errorText,
    this.validator,
    this.obscureText = false,
    this.hintText,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.readOnly = false,
    this.controller,
  });

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: widget.controller ?? _controller,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          labelStyle: theme.textTheme.bodyLarge,
          hintStyle: theme.textTheme.bodyLarge,
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
          errorText: widget.errorText,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          errorStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.red)),
      validator: widget.validator,
    );
  }
}
