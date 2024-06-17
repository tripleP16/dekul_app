import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/medical_history_form_body.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/register_beneficiary_page.dart';
import 'package:flutter/material.dart';

class MedicalHistoryScreen extends StatelessWidget {
  static const routeName = 'medical-history';

  const MedicalHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegisterBeneficiaryPage(
      title: 'Tallas e historial medico',
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete),
        ),
      ],
      child: const MedicalHistoryFormBody(),
    );
  }
}
