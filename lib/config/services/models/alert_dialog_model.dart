import 'package:flutter/material.dart';

class AlertDialogModel {
  final BuildContext context;
  final String title;
  final String content;
  final Widget icon;
  final List<Widget>? actions;
  final bool isDismissible;

  AlertDialogModel({
    required this.context,
    required this.title,
    required this.content,
    required this.icon,
    required this.actions,
    required this.isDismissible,
  });
}
