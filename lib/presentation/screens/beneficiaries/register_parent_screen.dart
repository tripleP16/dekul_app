import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/register_beneficiary_page.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/register_parent_form_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/helpers/alert_dialog_service.dart';
import '../../blocs/beneficiaries/register/register_beneficiary_bloc.dart';

class RegisterParentScreen extends StatelessWidget {
  static const routeName = 'register_parent';

  const RegisterParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterBeneficiaryPage(
      title: 'Representante',
      actions: [
        IconButton(
          onPressed: () {
            AlertDialogService.showAlertDialog(
              context,
              '¿Estás seguro ?',
              'Al cancelar el registro se perdera todo el progreso, ¿Desea continuar?',
              () {
                context.read<RegisterBeneficiaryBloc>().reset();
                context.go('/home');
              },
            );
          },
          icon: const Icon(Icons.delete),
        ),
      ],
      child: const RegisterParentFormBody(),
    );
  }
}
