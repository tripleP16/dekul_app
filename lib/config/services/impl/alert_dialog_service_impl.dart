import 'package:communitary_service_app/config/services/contracts/alert_dialog_service.dart';
import 'package:communitary_service_app/config/services/models/alert_dialog_model.dart';
import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlertDialogServiceImpl extends AlertDialogService {
  @override
  Future<T?> showNotificationDialog<T>(AlertDialogModel model) async {
    return await showDialog<T>(
        barrierDismissible: model.isDismissible,
        context: model.context,
        builder: (BuildContext context) {
          return AlertDialog(
            iconColor: AppColors.alertColor,
            title: Text(model.title),
            icon: model.icon,
            content: Text(model.content),
            actions: model.actions ??
                <Widget>[
                  CustomTextButton(
                    text: 'Ok',
                    color: AppColors.alertColor,
                    onPressed: () => context.pop(),
                  )
                ],
          );
        });
  }
}
