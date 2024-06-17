import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/presentation/shared/widgets/view_models/custom_chip_view_model.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final CustomChipViewModel viewModel;

  const CustomChip({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      deleteIcon: const Icon(
        Icons.close,
        size: 20,
        color: AppColors.primary,
      ),
      onDeleted: viewModel.onDelete,
      label: Text(viewModel.label),
    );
  }
}
