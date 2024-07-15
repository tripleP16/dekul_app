import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/domain/repositories/allergies/allergy_repository.dart';
import 'package:communitary_service_app/presentation/blocs/allergies/create_allergies/create_allergies_bloc.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_app_bar.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_elevated_button_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/text_input.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/wrappers/form_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlergiesScreen extends StatelessWidget {
  static const String routeName = 'alergies';

  const AlergiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAllergiesBloc(
        getIt<AllergiesRepository>(),
      ),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final allergiesState = context.watch<CreateAllergiesBloc>().state;
    final allergiesBloc = context.read<CreateAllergiesBloc>();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Crear Alergia'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 16,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                TextInputWidget(
                  labelText: 'Introduzca la alergia',
                  onChanged: allergiesBloc.onEditAllergyName,
                  errorText: allergiesState.allergy.errorMessage,
                ),
                const Spacer(),
                FormWrapper(
                  successContent: 'La alergia ha sido creada con éxito!',
                  child: CustomElevatedButton.dark(
                    onPressed: allergiesState.isFormValid
                        ? () async {
                            await context.read<FormCubit>().formSubmit(
                                  allergiesBloc.submitAllergy(),
                                );
                          }
                        : null,
                    text: 'Guardar',
                    elevation: 2,
                    width: 90,
                    height: 15,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
