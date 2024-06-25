import 'package:flutter/material.dart';

import '../../../view_models/autocomplete_with_chips_view_model.dart';

class ChipsShow extends StatelessWidget {
  const ChipsShow({
    super.key,
    required this.viewModel,
  });

  final AutocompleteWithChipsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runAlignment: WrapAlignment.start,
        runSpacing: 2,
        spacing: 8,
        children: [
          ..._buildChips(),
        ]);
  }

  List<Widget> _buildChips() {
    return viewModel.selectedItems.map((item) {
      return Chip(
        label: Text(item.label),
        onDeleted: () {
          viewModel.onDelete(item);
        },
      );
    }).toList();
  }
}
