import 'package:animate_do/animate_do.dart';
import 'package:communitary_service_app/config/themes/themes.dart';
import 'package:communitary_service_app/domain/models/beneficiaries/beneficiary_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BeneficiariesCard extends StatelessWidget {
  final BeneficiaryModel beneficiary;

  const BeneficiariesCard({
    super.key,
    required this.beneficiary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeInLeft(
      child: GestureDetector(
        onTap: () {
          context.push(
            '/beneficiaries/details/${beneficiary.id}',
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          height: 100,
          decoration: const BoxDecoration(
            color: AppColors.onPrimary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6,
              ),
            ],
          ),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Text(beneficiary.name.characters.first),
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${beneficiary.name} ${beneficiary.lastname}',
                        style: theme.textTheme.bodyLarge,
                      ),
                      Text(
                        'Edad : ${beneficiary.age}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (beneficiary.needsMedicalHistoryUpdate ?? false) ...[
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 60,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: const Icon(Icons.medical_information),
                ),
              ),
            ],
          ]),
        ),
      ),
    );
  }
}
