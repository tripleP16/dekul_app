import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_beneficiary/form_beneficiary_bloc.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/register_beneficiaries_form_body.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/register_beneficiary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBeneficiariesScreen extends StatelessWidget {
  static const String routeName = 'register_beneficiaries_screen';

  const RegisterBeneficiariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<FormBeneficiaryBloc>().reset();
      },
      child: const RegisterBeneficiaryPage(
        title: 'Registro de Beneficiarios',
        child: RegisterBeneficiariesFormBody(),
      ),
    );
  }
}
