import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlertDialogService {
  static void showAlertDialog(BuildContext context, String title,
      String message, VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(
            Icons.delete,
            size: 20,
            color: AppColors.primary,
          ),
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CustomTextButton(
              text: 'Cancelar',
              color: AppColors.primary,
              onPressed: () => context.pop(),
            ),
            CustomTextButton(
              text: 'OK',
              color: AppColors.primary,
              onPressed: onAccepted,
            )
          ],
        );
      },
    );
  }
}
