import 'package:communitary_service_app/config/services/contracts/snackbars_service.dart';
import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnackbarsServiceImpl implements SnackbarsService {
  @override
  Future<void> showSuccessSnackbar(String content, BuildContext context) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: content,
        backgroundColor: AppColors.successColor,
      ),
    );
  }

  @override
  Future<void> showInfoSnackbar(String content, BuildContext context) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: content,
        backgroundColor: AppColors.warningColor,
      ),
    );
  }

  @override
  Future<void> showErrorSnackbar(String content, BuildContext context) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: content,
        backgroundColor: AppColors.errorColor,
      ),
    );
  }
}
