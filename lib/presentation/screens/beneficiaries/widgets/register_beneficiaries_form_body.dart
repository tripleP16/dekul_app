import 'package:communitary_service_app/config/services/impl/date_format_service.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_beneficiary/form_beneficiary_bloc.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/gender.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBeneficiariesFormBody extends StatefulWidget {
  const RegisterBeneficiariesFormBody({
    super.key,
  });

  @override
  State<RegisterBeneficiariesFormBody> createState() =>
      _RegisterBeneficiariesFormBodyState();
}

class _RegisterBeneficiariesFormBodyState
    extends State<RegisterBeneficiariesFormBody> {
  final birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formBeneficiary = context.read<FormBeneficiaryBloc>();
    final formBeneficiaryState = context.watch<FormBeneficiaryBloc>().state;

    return SizedBox(
      height: size.height * 0.8,
      child: Column(
        children: [
          const CustomStepper(
            width: 0,
          ),
          VerticalSpacer.v36().createSpace(),
          TextInputWidget(
            initialValue: formBeneficiaryState.beneficiaryName.value,
            labelText: 'Nombres',
            onChanged: (p0) => formBeneficiary.changeName(p0),
            errorText: formBeneficiaryState.beneficiaryName.errorMessage,
          ),
          VerticalSpacer.v36().createSpace(),
          TextInputWidget(
            labelText: 'Apellidos',
            initialValue: formBeneficiaryState.beneficiaryLastname.value,
            onChanged: (p0) => formBeneficiary.changeLastName(p0),
            errorText: formBeneficiaryState.beneficiaryLastname.errorMessage,
          ),
          VerticalSpacer.v36().createSpace(),
          TextInputWidget(
            labelText: 'Fecha de Nacimiento',
            controller: birthdayController,
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(DateTime.now().year),
              );
              if (date != null) {
                formBeneficiary.birthdayChanged(date);
                birthdayController.text = DateFormatService.formatDate(date);
              }
            },
            onChanged: (value) {},
            errorText: formBeneficiaryState.beneficiaryBirthday.errorMessage,
            prefixIcon: const Icon(Icons.calendar_month),
          ),
          VerticalSpacer.v36().createSpace(),
          CustomCheckbox(
            label: '¿Practica algún deporte?',
            onChanged: (value) =>
                formBeneficiary.playingSportsChanged(value ?? false),
            value: formBeneficiaryState.isPlayingSports,
          ),
          VerticalSpacer.v36().createSpace(),
          CustomRadioButton<Gender>(
            label1: 'Masculino',
            label2: 'Femenino',
            onChanged: (value) =>
                formBeneficiary.genderChanged(value ?? Gender.male),
            value1: Gender.male,
            value2: Gender.female,
            generalLabel: 'Genero',
            groupValue1: formBeneficiaryState.beneficiaryGender.value,
            groupValue2: formBeneficiaryState.beneficiaryGender.value,
            errorMessage: formBeneficiaryState.beneficiaryGender.errorMessage,
          ),
          const Spacer(),
          CustomElevatedButton.light(
            onPressed: () {
              formBeneficiary.submit();
            },
            text: 'Continuar',
            elevation: 3,
            width: 100,
            height: 10,
          )
        ],
      ),
    );
  }
}
