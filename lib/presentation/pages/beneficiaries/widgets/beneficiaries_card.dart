import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/themes.dart';

class BeneficiariesCard extends StatelessWidget {
  final BeneficiaryModel beneficiary;
  const BeneficiariesCard({
    super.key,
    required this.beneficiary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        tileColor: AppColors.greyColor.withOpacity(0.4),
        title: Text(
          '${beneficiary.name} ${beneficiary.lastname}',
          style: theme.textTheme.bodyLarge,
        ),
        subtitle: Text(
          'Edad : ${beneficiary.age}',
          style: theme.textTheme.bodySmall,
        ),
        leading: CircleAvatar(
          child: Text(beneficiary.name.characters.first),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomElevatedButton.grey(
              elevation: 2,
              width: 2,
              height: 5,
              text: 'Editar',
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            const Badge(
              smallSize: 20,
              offset: Offset(100, 100),
            ),
          ],
        ),
      ),
    );
  }
}
