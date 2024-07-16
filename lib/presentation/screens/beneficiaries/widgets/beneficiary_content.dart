import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/view_models/beneficiary_content_view_model.dart';
import 'package:flutter/material.dart';

final possibleColorsBasedOnTheStatus = {
  BeneficiaryViewModelState.ok: AppColors.successColor,
  BeneficiaryViewModelState.warning: AppColors.warningColor,
  BeneficiaryViewModelState.bad: AppColors.errorColor,
  BeneficiaryViewModelState.text: null,
};

class BeneficiaryContent extends StatelessWidget {
  final BeneficiaryContentViewModel contentViewModel;
  const BeneficiaryContent({super.key, required this.contentViewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              contentViewModel.title,
              style: theme.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )),
        Expanded(
          flex: 1,
          child: Text(
            contentViewModel.value,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: possibleColorsBasedOnTheStatus[contentViewModel.state],
            ),
          ),
        ),
      ],
    );
  }
}
