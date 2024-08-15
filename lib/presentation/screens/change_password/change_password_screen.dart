import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/domain/repositories/change_password/change_password_repository.dart';
import 'package:communitary_service_app/presentation/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/text_input.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets/forms/wrappers/form_wrapper.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String routeName = 'change_password';
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cambiar Contraseña'),
      body: BlocProvider(
        create: (context) =>
            ChangePasswordBloc(getIt<ChangePasswordRepository>()),
        child: const ChangePasswordFormBody(),
      ),
    );
  }
}

class ChangePasswordFormBody extends StatelessWidget {
  const ChangePasswordFormBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentFormState = context.watch<ChangePasswordBloc>().state;
    final currentForm = context.read<ChangePasswordBloc>();
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Center(
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            TextInputWidget(
              labelText: 'Introdzca la contraseña actual',
              onChanged: currentForm.onOldPasswordChanged,
              errorText: currentFormState.oldPassword.errorMessage,
              initialValue: currentFormState.oldPassword.value,
              obscureText: true,
            ),
            const Spacer(
              flex: 1,
            ),
            TextInputWidget(
              labelText: 'Nueva Contraseña',
              errorText: currentFormState.newPassword.errorMessage,
              initialValue: currentFormState.newPassword.value,
              onChanged: currentForm.onNewPasswordChanged,
              obscureText: true,
            ),
            const Spacer(
              flex: 1,
            ),
            TextInputWidget(
              labelText: 'Repite la nueva Contraseña',
              onChanged: currentForm.onConfirmPasswordChanged,
              initialValue: currentFormState.confirmPassword.value,
              errorText: currentFormState.errorMessage ??
                  currentFormState.confirmPassword.errorMessage,
              obscureText: true,
            ),
            const Spacer(
              flex: 2,
            ),
            FormWrapper(
              successContent:
                  'La contraseña ha sido actualizada correctamente.',
              child: CustomElevatedButton.dark(
                onPressed:
                    currentFormState.isValid && !currentFormState.isLoading
                        ? () async {
                            context.read<FormCubit>().formSubmit(
                                  currentForm.onSubmit(),
                                );
                          }
                        : null,
                text: 'Continuar',
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
