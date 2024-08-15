import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/domain/repositories/beneficiaries/beneficiaries_repository.dart';
import 'package:communitary_service_app/presentation/blocs/update_medical_history/update_medical_history_bloc.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_app_bar.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_elevated_button_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/text_input.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/wrappers/form_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalHistoryUpdateScreen extends StatelessWidget {
  static const routeName = 'medical-history-update';
  final String id;
  const MedicalHistoryUpdateScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateMedicalHistoryBloc(
        getIt<BeneficiariesRepository>(),
        id,
      ),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Tallas e historial medico', ),
        body: UpdateMedicalHistoryBody(
          id: id,
        ),
      ),
    );
  }
}

class UpdateMedicalHistoryBody extends StatelessWidget {
  final String id;
  const UpdateMedicalHistoryBody({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    if (id == '') {
      return const Center(
        child: Text('No se ha encontrado el historial médico'),
      );
    }

    final formState = context.watch<UpdateMedicalHistoryBloc>().state;
    final formBloc = context.read<UpdateMedicalHistoryBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Column(
        children: [
          const Spacer(
            flex: 1,
          ),
          TextInputWidget(
            labelText: 'Peso',
            onChanged: (p0) {
              formBloc.onWeightChanged(
                double.tryParse(p0) ?? 0.0,
              );
            },
            keyboardType: TextInputType.number,
            errorText: formState.weight.errorMessage,
          ),
          const Spacer(
            flex: 1,
          ),
          TextInputWidget(
            labelText: 'Estatura',
            onChanged: (p0) {
              formBloc.onHeightChanged(
                int.tryParse(p0) ?? 0,
              );
            },
            keyboardType: TextInputType.number,
            errorText: formState.height.errorMessage,
          ),
          const Spacer(
            flex: 2,
          ),
          FormWrapper(
            successContent:
                'Se ha actualizado el historial médico correctamente',
            child: CustomElevatedButton.dark(
              onPressed: formState.isValid
                  ? () async {
                      context.read<FormCubit>().formSubmit(
                            formBloc.onSubmit(),
                          );
                    }
                  : null,
              text: 'Guardar',
              elevation: 3,
              width: 100,
              height: 15,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
