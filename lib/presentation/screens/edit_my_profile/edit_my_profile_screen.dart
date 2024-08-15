import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/domain/repositories/my_profile/my_profile_repository.dart';
import 'package:communitary_service_app/presentation/blocs/my_profile/edit_my_profile_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/my_profile/edit_my_profile_state.dart';
import 'package:communitary_service_app/presentation/screens/edit_my_profile/widgets/error_card.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/wrappers/form_wrapper.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditMyProfileScreen extends StatelessWidget {
  static const String routeName = 'edit_my_profile';
  const EditMyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Editar mi perfil',
      ),
      body: BlocProvider(
        create: (context) => EditMyProfileBloc(
          getIt<MyProfileRepository>(),
        ),
        child: const EditMyProfileFormBody(),
      ),
    );
  }
}

class EditMyProfileFormBody extends StatelessWidget {
  const EditMyProfileFormBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMyProfileBloc, EditMyProfileState>(
      builder: (context, state) {
        if (state.isRetrieving) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.isErrored) {
          return const ErrorCard();
        }

        return const EditProfileForm();
      },
    );
  }
}

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            TextInputWidget(
              labelText: 'Nombre',
              onChanged: context.read<EditMyProfileBloc>().onNameChanged,
              errorText:
                  context.watch<EditMyProfileBloc>().state.name.errorMessage,
              initialValue: context.watch<EditMyProfileBloc>().state.name.value,
            ),
            const Spacer(
              flex: 1,
            ),
            TextInputWidget(
              labelText: 'Apellido',
              onChanged: context.read<EditMyProfileBloc>().onLastNameChanged,
              errorText: context
                  .watch<EditMyProfileBloc>()
                  .state
                  .lastname
                  .errorMessage,
              initialValue:
                  context.watch<EditMyProfileBloc>().state.lastname.value,
            ),
            const Spacer(
              flex: 1,
            ),
            TextInputWidget(
              labelText: 'Correo electronico',
              onChanged: context.read<EditMyProfileBloc>().onEmailChanged,
              errorText:
                  context.watch<EditMyProfileBloc>().state.email.errorMessage,
              initialValue:
                  context.watch<EditMyProfileBloc>().state.email.value,
            ),
            const Spacer(
              flex: 2,
            ),
            FormWrapper(
              successContent: 'El perfil se ha actualizado correctamente ',
              child: CustomElevatedButton.dark(
                onPressed:
                    !context.watch<EditMyProfileBloc>().state.isLoading &&
                            context.watch<EditMyProfileBloc>().state.isValid
                        ? () {
                            context.read<FormCubit>().formSubmit(
                                  context.read<EditMyProfileBloc>().submit(),
                                );
                          }
                        : null,
                text: 'Guardar',
                elevation: 3,
                width: 80,
                height: 20,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
