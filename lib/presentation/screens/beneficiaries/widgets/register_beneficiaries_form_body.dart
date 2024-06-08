import 'package:communitary_service_app/config/services/impl/date_format_service.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/form_beneficiary/form_beneficiary_bloc.dart';
import 'package:communitary_service_app/presentation/shared/form_inputs/gender.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBeneficiariesFormBody extends StatelessWidget {
  const RegisterBeneficiariesFormBody({
    super.key,
  });

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
            labelText: 'Nombres',
            onChanged: (p0) => formBeneficiary.changeName(p0),
            errorText: formBeneficiaryState.beneficiaryName.errorMessage,
          ),
          VerticalSpacer.v36().createSpace(),
          TextInputWidget(
            labelText: 'Apellidos',
            onChanged: (p0) => formBeneficiary.changeLastName(p0),
            errorText: formBeneficiaryState.beneficiaryLastname.errorMessage,
          ),
          VerticalSpacer.v36().createSpace(),
          TextInputWidget(
            labelText: 'Fecha de Nacimiento',
            hintText: formBeneficiaryState.beneficiaryBirthday.value != null
                ? DateFormatService.formatDate(
                    formBeneficiaryState.beneficiaryBirthday.value!)
                : null,
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(DateTime.now().year - 1),
              );
              if (date != null) {
                formBeneficiary.birthdayChanged(date);
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
          VerticalSpacer.v36().createSpace(),
          CustomElevatedButton.light(
            onPressed: () {
              formBeneficiary.submit();
            },
            text: 'Continuar',
            elevation: 3,
            width: 20,
            height: 10,
          )
        ],
      ),
    );
  }
}
