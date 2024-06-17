import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/forms/inputs/forms.dart';

class MedicalHistoryFormBody extends StatelessWidget {
  const MedicalHistoryFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height * 0.8,
        child: Column(
          children: [
            CustomStepper(width: size.width),
            VerticalSpacer.v40().createSpace(),
            TextInputWidget(
              labelText: 'Altura en cm',
              onChanged: (p0) {},
              keyboardType: TextInputType.number,
            ),
            VerticalSpacer.v36().createSpace(),
            TextInputWidget(
              labelText: 'Peso en kg',
              keyboardType: TextInputType.number,
              onChanged: (p0) {},
            ),
            VerticalSpacer.v36().createSpace(),
            const AutocompleteWithChips(),
            VerticalSpacer.v36().createSpace(),
            const Spacer(),
            CustomElevatedButton.dark(
              onPressed: () {},
              text: 'Guardar',
              elevation: 3,
              width: 100,
              height: 15,
            )
          ],
        ));
  }
}
