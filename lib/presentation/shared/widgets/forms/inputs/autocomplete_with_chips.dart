import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.daRT';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AutocompleteWithChips extends StatelessWidget {
  const AutocompleteWithChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Wrap(
            runAlignment: WrapAlignment.start,
            runSpacing: 2,
            spacing: 8,
            children: []),
        TextInputWidget(
          labelText: 'Alergias',
          onChanged: (p0) {},
        ),
        VerticalSpacer.v36().createSpace(),
      ],
    );
  }
}
