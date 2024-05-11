import 'package:communitary_service_app/presentation/shared/widgets/forms/forms.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/login/login_bloc.dart';

class FormComponents extends StatelessWidget {
  const FormComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        VerticalSpacer(60).createSpace(),
        TextInputWidget(
          labelText: 'Email',
          onChanged: context.read<LoginBloc>().emailChanged,
          keyboardType: TextInputType.emailAddress,
          errorText: context.watch<LoginBloc>().state.email.errorMessage,
        ),
        VerticalSpacer(60).createSpace(),
        TextInputWidget(
          labelText: 'Contraseña',
          keyboardType: TextInputType.visiblePassword,
          onChanged: context.read<LoginBloc>().passwordChanged,
          errorText: context.watch<LoginBloc>().state.password.errorMessage,
          obscureText: true,
        ),
        VerticalSpacer(60).createSpace(),
        const _SubmitButton(),
        VerticalSpacer.v34().createSpace(),
        const CustomTextButton.url(
          onPressed: null,
          text: '¿Olvidaste la contraseña?',
          fontSize: 16,
        )
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.loginStatus == LoginStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return CustomElevatedButton.dark(
          onPressed: context.watch<LoginBloc>().state.isValid
              ? () async {
                  await context.read<LoginBloc>().submit();
                }
              : null,
          text: 'Continuar',
          width: 80,
          height: 20,
          elevation: 12,
        );
      },
    );
  }
}
