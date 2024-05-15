import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color color;
  final double fontSize;

  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.color,
    this.fontSize = 16,
  });

  const CustomTextButton.url({
    Key? key,
    required void Function()? onPressed,
    required String text,
    required double fontSize,
  }) : this(
            key: key,
            color: AppColors.urlColor,
            onPressed: onPressed,
            text: text,
            fontSize: fontSize);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: fontSize, color: color)),
    );
  }
}
