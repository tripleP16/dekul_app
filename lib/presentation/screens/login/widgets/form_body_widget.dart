import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/wrappers/form_wrapper.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/login/login_bloc.dart';

class FormComponents extends StatelessWidget {
  const FormComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isPosted) {}
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VerticalSpacer(60).createSpace(),
          TextInputWidget(
            labelText: 'Email',
            initialValue: context.watch<LoginBloc>().state.email.value,
            onChanged: context.read<LoginBloc>().emailChanged,
            keyboardType: TextInputType.emailAddress,
            errorText: context.watch<LoginBloc>().state.email.errorMessage,
          ),
          VerticalSpacer(60).createSpace(),
          TextInputWidget(
            labelText: 'Contraseña',
            initialValue: context.watch<LoginBloc>().state.password.value,
            keyboardType: TextInputType.visiblePassword,
            onChanged: context.read<LoginBloc>().passwordChanged,
            errorText: context.watch<LoginBloc>().state.password.errorMessage,
            obscureText: true,
          ),
          VerticalSpacer(60).createSpace(),
          const _SubmitButton(),
          VerticalSpacer.v34().createSpace(),
          CustomTextButton.url(
            onPressed: () {
              context.push('/forgot_password/email');
            },
            text: '¿Olvidaste la contraseña?',
            fontSize: 16,
          )
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();
  @override
  Widget build(BuildContext context) {
    return FormWrapper(
      successContent: 'Se ha iniciado sesión correctamente',
      child: CustomElevatedButton.dark(
        onPressed: context.watch<LoginBloc>().state.isValid
            ? () async {
                await context.read<FormCubit>().formSubmit(
                      context.read<LoginBloc>().submit(),
                    );
              }
            : null,
        text: 'Continuar',
        width: 80,
        height: 20,
        elevation: 12,
      ),
    );
  }
}
