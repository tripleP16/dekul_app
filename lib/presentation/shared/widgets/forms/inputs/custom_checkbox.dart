import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;
  final void Function(bool?) onChanged;
  final bool value;
  const CustomCheckbox({
    super.key,
    required this.label,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyLarge,
          ),
          Transform.scale(
            scale: 1.5,
            child: Checkbox(
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states
                    .any((element) => element == MaterialState.selected)) {
                  return AppColors.alertColor;
                }
                return AppColors.primarySurface;
              }),
              onChanged: onChanged,
              value: value,
            ),
          ),
        ],
      ),
    );
  }
}
