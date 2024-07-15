import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color color;

  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.color,
  });

  const CustomTextButton.url({
    Key? key,
    required void Function()? onPressed,
    required String text,
  }) : this(
          key: key,
          color: AppColors.urlColor,
          onPressed: onPressed,
          text: text,
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: onPressed,
      child: Text(text,
          style: theme.textTheme.bodyLarge!.copyWith(
            color: color,
          )),
    );
  }
}
