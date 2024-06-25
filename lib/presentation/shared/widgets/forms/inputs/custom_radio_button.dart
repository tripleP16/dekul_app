import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T groupValue1;
  final T groupValue2;
  final T value1;
  final T value2;
  final String label1;
  final String generalLabel;
  final String label2;
  final String? errorMessage;
  final void Function(T?)? onChanged;
  const CustomRadioButton({
    super.key,
    required this.value1,
    required this.value2,
    required this.label1,
    required this.label2,
    required this.generalLabel,
    required this.groupValue1,
    required this.groupValue2,
    this.onChanged,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            generalLabel,
            style: theme.textTheme.bodyLarge,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Material(
                child: RadioListTile<T>(
                  title: Text(
                    label1,
                    style: theme.textTheme.bodySmall,
                  ),
                  groupValue: groupValue1,
                  value: value1,
                  onChanged: onChanged,
                ),
              ),
            ),
            Expanded(
              child: Material(
                child: RadioListTile<T>(
                  title: Text(
                    label2,
                    style: theme.textTheme.bodySmall,
                  ),
                  groupValue: groupValue2,
                  value: value2,
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: theme.textTheme.bodySmall!.copyWith(
              color: AppColors.alertColor,
            ),
          ),
      ],
    );
  }
}
