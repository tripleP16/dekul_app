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
          Text('Alergias ${viewModel.items.length}'),
        ]);
  }
}
