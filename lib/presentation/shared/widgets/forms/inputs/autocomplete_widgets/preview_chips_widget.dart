import 'package:flutter/material.dart';

import '../../../view_models/custom_chip_view_model.dart';

class PreviewChipWidget extends StatelessWidget {
  final List<CustomChipViewModel> optionsList;
  final Function(CustomChipViewModel) onTapped;

  const PreviewChipWidget({
    super.key,
    required this.optionsList,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4,
        child: SizedBox(
          width: size.width * 0.5,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: optionsList.length,
            itemBuilder: (context, index) {
              final option = optionsList[index];
              return ListTile(
                title: Text(option.label),
                onTap: () {
                  onTapped(option);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
