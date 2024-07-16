import 'package:communitary_service_app/domain/models/beneficiaries/get_beneficiary_model.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/beneficiary_content.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/view_models/beneficiary_content_view_model.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/widgets.dart';

class BeneficiaryDetail extends StatelessWidget {
  final GetBeneficiaryModel model;
  const BeneficiaryDetail({
    super.key,
    required this.model,
  });

  BeneficiaryViewModelState _getCurrentStatus() {
    if (model.bmiState == BeneficiaryBMIState.ok) {
      return BeneficiaryViewModelState.ok;
    }
    if (model.bmiState == BeneficiaryBMIState.warning) {
      return BeneficiaryViewModelState.warning;
    }

    return BeneficiaryViewModelState.bad;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 10,
      ),
      child: SizedBox(
        height: size.height * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BeneficiaryContent(
              contentViewModel: BeneficiaryContentViewModel(
                state: BeneficiaryViewModelState.text,
                title: 'Beneficiario',
                value: model.fullName,
              ),
            ),
            BeneficiaryContent(
              contentViewModel: BeneficiaryContentViewModel(
                state: BeneficiaryViewModelState.text,
                title: 'Representante',
                value: model.parent.fullName,
              ),
            ),
            BeneficiaryContent(
              contentViewModel: BeneficiaryContentViewModel(
                title: 'Telefono',
                state: BeneficiaryViewModelState.text,
                value: model.parent.phoneNumber,
              ),
            ),
            BeneficiaryContent(
              contentViewModel: BeneficiaryContentViewModel(
                title: 'Altura',
                state: BeneficiaryViewModelState.text,
                value: model.currentHeight,
              ),
            ),
            BeneficiaryContent(
              contentViewModel: BeneficiaryContentViewModel(
                title: 'Peso',
                state: BeneficiaryViewModelState.text,
                value: model.currentWeight,
              ),
            ),
            BeneficiaryContent(
              contentViewModel: BeneficiaryContentViewModel(
                title: 'Edad',
                state: BeneficiaryViewModelState.text,
                value: model.age.toString(),
              ),
            ),
            BeneficiaryContent(
              contentViewModel: BeneficiaryContentViewModel(
                title: 'BMI',
                state: _getCurrentStatus(),
                value: model.currentBMI,
              ),
            ),
            if (model.allergies.isNotEmpty)
              BeneficiaryContent(
                contentViewModel: BeneficiaryContentViewModel(
                  title: 'Alergias',
                  state: BeneficiaryViewModelState.bad,
                  value: model.allergiesString,
                ),
              ),
            VerticalSpacer.v30().createSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton.light(
                  onPressed: () {},
                  text: 'Actualizar medidas',
                  elevation: 2,
                  width: 35,
                  height: 10,
                ),
                if (model.needsMedicalHistoryUpdate) ...[
                  const SizedBox(width: 10),
                  const Badge(
                    largeSize: 50,
                    smallSize: 20,
                  )
                ]
              ],
            )
          ],
        ),
      ),
    ));
  }
}
