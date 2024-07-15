import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_parent/form_parent_bloc.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/widgets.dart';

class RegisterParentFormBody extends StatelessWidget {
  const RegisterParentFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final parentState = context.watch<FormParentBloc>().state;
    final parentForm = context.read<FormParentBloc>();
    return SizedBox(
      height: size.height * 0.8,
      child: Column(
        children: [
          CustomStepper(width: size.width * 0.5),
          const Spacer(),
          TextInputWidget(
            labelText: 'Nombres',
            onChanged: parentForm.setName,
            initialValue: parentState.name.value,
            errorText: parentState.name.errorMessage,
          ),
          VerticalSpacer.v48().createSpace(),
          TextInputWidget(
            labelText: 'Apellidos',
            onChanged: parentForm.setLastname,
            initialValue: parentState.lastname.value,
            errorText: parentState.lastname.errorMessage,
          ),
          VerticalSpacer.v48().createSpace(),
          TextInputWidget(
            labelText: 'Numero de Telefono',
            onChanged: parentForm.setPhone,
            initialValue: parentState.phoneNumber.value,
            keyboardType: TextInputType.phone,
            errorText: parentState.phoneNumber.errorMessage,
          ),
          const Spacer(),
          CustomElevatedButton.light(
            onPressed: () {
              parentForm.submit();
            },
            text: 'Continuar',
            elevation: 2,
            width: 100,
            height: 10,
          ),
        ],
      ),
    );
  }
}
