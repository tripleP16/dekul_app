import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final double elevation;
  final double textSize;
  final FontWeight fontWeight;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    required this.elevation,
    required this.textSize,
    required this.fontWeight,
  });

  const CustomElevatedButton.light({
    Key? key,
    required void Function()? onPressed,
    required String text,
    required double textSize,
    required double elevation,
  }) : this(
            key: key,
            onPressed: onPressed,
            backgroundColor: AppColors.lightColor,
            textColor: AppColors.primary,
            text: text,
            textSize: textSize,
            elevation: elevation,
            fontWeight: FontWeight.normal);

  const CustomElevatedButton.dark({
    Key? key,
    required void Function()? onPressed,
    required String text,
    required double textSize,
    required double elevation,
  }) : this(
            key: key,
            onPressed: onPressed,
            backgroundColor: AppColors.primary,
            textColor: AppColors.onPrimary,
            text: text,
            textSize: textSize,
            elevation: elevation,
            fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStatePropertyAll<double>(elevation),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.disabled;
            }
            return backgroundColor;
          }),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Text(text,
              style: TextStyle(
                  color: onPressed != null ? textColor : AppColors.primary,
                  fontWeight: fontWeight,
                  fontSize: textSize)),
        ));
  }
}
