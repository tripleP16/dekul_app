import 'package:flutter/material.dart';

import '../../../view_models/custom_chip_view_model.dart';

class PreviewChipWidget extends StatelessWidget {
  const PreviewChipWidget({
    super.key,
    required this.optionsList,
    required this.onTapped,
  });

  final List<CustomChipViewModel> optionsList;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4,
        child: Container(
          width: size.width * 0.5,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: optionsList.length,
            itemBuilder: (context, index) {
              final option = optionsList[index];
              return ListTile(
                title: Text(option.label),
                onTap: onTapped,
              );
            },
          ),
        ),
      ),
    );
  }
}
