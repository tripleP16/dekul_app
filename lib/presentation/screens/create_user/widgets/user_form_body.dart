import 'package:communitary_service_app/domain/models/privilege/privilege_model.dart';
import 'package:communitary_service_app/presentation/blocs/create_user/user_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/create_user/user_state.dart';
import 'package:communitary_service_app/presentation/blocs/privileges/privileges_cubit.dart';
import 'package:communitary_service_app/presentation/blocs/privileges/privileges_state.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_elevated_button_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/wrappers/form_wrapper.dart';
import 'package:communitary_service_app/presentation/shared/widgets/view_models/autocomplete_with_chips_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFormBody extends StatelessWidget {
  const UserFormBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formState = context.watch<UserBloc>().state;
    final form = context.read<UserBloc>();
    return BlocBuilder<PrivilegesCubit, PrivilegesState>(
      builder: (context, state) {
        if (state.isLoading ||
            formState.formState == UserFormState.isLoadingToEdit) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.errorMessage != null) {
          return Center(
            child: Text(state.errorMessage!),
          );
        }

        final privileges = state.getCustomChipViewModels();
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 5,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                TextInputWidget(
                  labelText: 'Nombre',
                  onChanged: form.onEditName,
                  initialValue: formState.name.value,
                  errorText: formState.name.errorMessage,
                ),
                const SizedBox(
                  height: 60,
                ),
                TextInputWidget(
                  labelText: 'Apellido',
                  onChanged: form.onEditLastname,
                  initialValue: formState.lastname.value,
                  errorText: formState.lastname.errorMessage,
                ),
                const SizedBox(
                  height: 60,
                ),
                TextInputWidget(
                  labelText: 'Correo Electronico',
                  onChanged: form.onEditEmail,
                  initialValue: formState.email.value,
                  errorText: formState.email.errorMessage,
                ),
                const SizedBox(
                  height: 60,
                ),
                AutocompleteWithChips(
                  viewModel: AutocompleteWithChipsViewModel(
                    items: privileges,
                    selectedItems: formState.getCustomChipViewModels(),
                    onSelected: (p0) {
                      form.onAddPrivilege(
                        PrivilegeModel(
                          id: p0.value,
                          name: p0.label,
                        ),
                      );
                    },
                    hintText: 'Privilegios',
                    onDelete: (p0) {
                      form.onRemovePrivilege(
                        PrivilegeModel(
                          id: p0.value,
                          name: p0.label,
                        ),
                      );
                    },
                    labelText: 'Privilegios',
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                FormWrapper(
                  successContent: formState.isEditing
                      ? 'El usuario ha sido actualizado exitosamente'
                      : 'El Usuario ha sido creado exitosamente',
                  child: CustomElevatedButton.dark(
                    onPressed: formState.isValid
                        ? () async {
                            context.read<FormCubit>().formSubmit(
                                  form.onSubmit(),
                                );
                          }
                        : null,
                    text: 'Guardar',
                    elevation: 3,
                    width: 100,
                    height: 15,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
