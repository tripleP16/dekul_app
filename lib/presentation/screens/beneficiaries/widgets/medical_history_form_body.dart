import 'package:communitary_service_app/domain/models/allergies/allergies_model.dart';
import 'package:communitary_service_app/presentation/blocs/allergies/allergies_cubit.dart';
import 'package:communitary_service_app/presentation/blocs/allergies/allergies_state.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/medical_history_form/medical_history_form_state.dart';
import 'package:communitary_service_app/presentation/blocs/beneficiaries/register/register_beneficiary_bloc.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/wrappers/form_wrapper.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/beneficiaries/medical_history_form/medical_history_form_bloc.dart';
import '../../../shared/widgets/forms/inputs/forms.dart';
import '../../../shared/widgets/view_models/autocomplete_with_chips_view_model.dart';

class MedicalHistoryFormBody extends StatefulWidget {
  const MedicalHistoryFormBody({super.key});

  @override
  State<MedicalHistoryFormBody> createState() => _MedicalHistoryFormBodyState();
}

class _MedicalHistoryFormBodyState extends State<MedicalHistoryFormBody> {
  bool isLoading = false;

  @override
  void initState() {
    context.read<AllergiesCubit>().fetchAllergies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final medicalHistoryFormState =
        context.watch<MedicalHistoryFormBloc>().state;
    final medicalHistoryFormBloc = context.read<MedicalHistoryFormBloc>();

    return BlocBuilder<AllergiesCubit, AllergiesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final allergies = state.getCustomChipViewModels();
        return SizedBox(
          height: size.height * 0.8,
          child: Column(
            children: [
              CustomStepper(width: size.width),
              VerticalSpacer.v40().createSpace(),
              TextInputWidget(
                initialValue: medicalHistoryFormState.height.value.toString(),
                errorText: medicalHistoryFormState.height.errorMessage,
                labelText: 'Altura en cm',
                onChanged: (p0) =>
                    medicalHistoryFormBloc.onEditHeight(int.tryParse(p0) ?? -1),
                keyboardType: TextInputType.number,
              ),
              VerticalSpacer.v36().createSpace(),
              TextInputWidget(
                initialValue: medicalHistoryFormState.weight.value.toString(),
                labelText: 'Peso en kg',
                errorText: medicalHistoryFormState.weight.errorMessage,
                keyboardType: TextInputType.number,
                onChanged: (p0) => medicalHistoryFormBloc
                    .onEditWeight(double.tryParse(p0) ?? -1),
              ),
              VerticalSpacer.v36().createSpace(),
              AutocompleteWithChips(
                viewModel: AutocompleteWithChipsViewModel(
                  items: allergies,
                  selectedItems:
                      medicalHistoryFormState.getCustomChipViewModels(),
                  onSelected: (p0) {
                    medicalHistoryFormBloc.onAddAllergy(
                      AllergiesModel(
                        id: p0.value,
                        name: p0.label,
                      ),
                    );
                  },
                  hintText: 'Alergias',
                  onDelete: (p0) {
                    medicalHistoryFormBloc.onRemoveAllergy(
                      AllergiesModel(
                        id: p0.value,
                        name: p0.label,
                      ),
                    );
                  },
                  labelText: 'Alergias',
                ),
              ),
              VerticalSpacer.v36().createSpace(),
              const Spacer(),
              BlocConsumer<MedicalHistoryFormBloc, MedicalHistoryFormState>(
                listener: (context, state) async {
                  if (state.isValid) {
                    await context.read<FormCubit>().formSubmit(
                        context.read<RegisterBeneficiaryBloc>().submit());
                  }
                },
                builder: (context, state) {
                  return FormWrapper(
                    successContent:
                        'El beneficiario ha sido registrado correctamente',
                    child: CustomElevatedButton.dark(
                      onPressed: () async {
                        medicalHistoryFormBloc.submit();
                      },
                      text: 'Guardar',
                      elevation: 3,
                      width: 100,
                      height: 15,
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
