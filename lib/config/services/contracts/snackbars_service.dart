import 'package:flutter/material.dart';

abstract class SnackbarsService {
  Future<void> showSuccessSnackbar(String content, BuildContext context);

  Future<void> showErrorSnackbar(String content, BuildContext context);

  Future<void> showInfoSnackbar(String content, BuildContext context);
}
