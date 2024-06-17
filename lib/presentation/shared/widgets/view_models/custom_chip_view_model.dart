import 'package:flutter/material.dart';

class CustomChipViewModel {
  final String label;
  final VoidCallback onDelete;
  final String value;

  CustomChipViewModel({
    required this.label,
    required this.onDelete,
    required this.value,
  });
}
