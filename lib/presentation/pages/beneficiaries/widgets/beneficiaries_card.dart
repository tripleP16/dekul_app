import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/permissions_service.dart';
import 'package:communitary_service_app/config/services/models/permissions_enum.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        onTap: () {
          context.push(
            '/beneficiaries/details/${beneficiary.id}',
          );
        },
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
            FutureBuilder(
                future: getIt<PermissionsService>()
                    .hasAccess(PermissionsEnum.updateBeneficiary),
                builder: (context, snapshot) {
                  if (snapshot.data ?? false) {
                    return CustomElevatedButton.grey(
                      elevation: 2,
                      width: 2,
                      height: 5,
                      text: 'Editar',
                      onPressed: () {},
                    );
                  }
                  return const SizedBox.shrink();
                }),
            if (beneficiary.needsMedicalHistoryUpdate ?? false) ...[
              const SizedBox(width: 10),
              const Badge(
                smallSize: 20,
                offset: Offset(100, 100),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
