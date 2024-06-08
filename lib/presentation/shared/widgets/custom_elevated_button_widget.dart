import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final double elevation;
  final double width;
  final double height;
  final FontWeight fontWeight;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    required this.elevation,
    required this.fontWeight,
    required this.width,
    required this.height,
  });

  const CustomElevatedButton.light({
    Key? key,
    required void Function()? onPressed,
    required String text,
    required double elevation,
    required double width,
    required double height,
  }) : this(
            key: key,
            onPressed: onPressed,
            backgroundColor: AppColors.lightColor,
            textColor: AppColors.primary,
            text: text,
            elevation: elevation,
            fontWeight: FontWeight.normal,
            width: width,
            height: height);

  const CustomElevatedButton.dark({
    Key? key,
    required void Function()? onPressed,
    required String text,
    required double elevation,
    required double width,
    required double height,
  }) : this(
          key: key,
          onPressed: onPressed,
          backgroundColor: AppColors.primary,
          textColor: AppColors.onPrimary,
          text: text,
          elevation: elevation,
          fontWeight: FontWeight.normal,
          width: width,
          height: height,
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll<double>(elevation),
        backgroundColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.disabled;
          }
          return backgroundColor;
        }),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width, vertical: height),
        child: Text(
          text,
          style: theme.textTheme.bodyLarge!.copyWith(
            color: onPressed != null ? textColor : AppColors.primary,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
