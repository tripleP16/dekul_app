import 'package:communitary_service_app/config/helpers/alert_dialog_service.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/register/register_beneficiary_bloc.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/medical_history_form_body.dart';
import 'package:communitary_service_app/presentation/screens/beneficiaries/widgets/register_beneficiary_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MedicalHistoryScreen extends StatelessWidget {
  static const routeName = 'medical-history';

  const MedicalHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegisterBeneficiaryPage(
      title: 'Tallas e historial medico',
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
      child: const MedicalHistoryFormBody(),
    );
  }
}
