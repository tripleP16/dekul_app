import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/autocomplete_widgets/autocomplete_body.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/autocomplete_widgets/chips_show.dart';
import 'package:communitary_service_app/presentation/shared/widgets/view_models/autocomplete_with_chips_view_model.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AutocompleteWithChips extends StatelessWidget {
  final AutocompleteWithChipsViewModel viewModel;

  const AutocompleteWithChips({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChipsShow(viewModel: viewModel),
        AutoCompleteBody(viewModel: viewModel),
        VerticalSpacer.v36().createSpace(),
      ],
    );
  }
}
