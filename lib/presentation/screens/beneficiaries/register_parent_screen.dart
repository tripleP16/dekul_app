import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/register_beneficiary_page.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/register_parent_form_body.dart';
import 'package:flutter/material.dart';

class RegisterParentScreen extends StatelessWidget {
  static const routeName = 'register_parent';

  const RegisterParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterBeneficiaryPage(
      title: 'Representante',
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete),
        ),
      ],
      child: const RegisterParentFormBody(),
    );
  }
}
