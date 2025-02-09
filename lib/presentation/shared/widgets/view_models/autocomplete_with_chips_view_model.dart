import 'package:communitary_service_app/presentation/shared/widgets/view_models/custom_chip_view_model.dart';
import 'package:flutter/material.dart';

class AutocompleteWithChipsViewModel {
  final List<CustomChipViewModel> items;
  final List<CustomChipViewModel> selectedItems;
  final Function(CustomChipViewModel) onSelected;
  final Function(CustomChipViewModel) onDelete;
  final String labelText;
  final String hintText;
  final IconData? icon;
  final Function(String)? onChanged;
  AutocompleteWithChipsViewModel({
    required this.items,
    required this.onSelected,
    required this.onDelete,
    required this.labelText,
    required this.hintText,
    required this.selectedItems,
    this.icon,
    this.onChanged,
  });
}
