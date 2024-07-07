import 'package:communitary_service_app/presentation/blocs/forgot_password/create_code_bloc/create_code_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/create_code_bloc/create_code_state.dart';
import 'package:communitary_service_app/presentation/screens/forgot_password/view_models/forgot_password_body_view_model.dart';
import 'package:communitary_service_app/presentation/screens/forgot_password/widgets/forgot_password_body.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/wrappers/form_wrapper.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordEmail extends StatelessWidget {
  static const String routeName = 'forgot_password_email';
  const ForgotPasswordEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<CreateCodeBloc>().reset();
      },
      child: const Scaffold(
        appBar: CustomAppBar(title: 'Recuperacion de contraseña'),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final createCodeState = context.watch<CreateCodeBloc>().state;
    return Padding(
      padding: const EdgeInsets.all(35.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: BlocListener<CreateCodeBloc, CreateCodeStateInput>(
            listener: (context, state) {
              if (state.state == CreateCodeState.success) {
                context.push('/forgot_password/code');
              }
            },
            child: FormWrapper(
              successContent: 'El codigo se ha enviado con exito',
              child: FogotPasswordBody(
                viewModel: ForgotPasswordBodyViewModel(
                  labelText: 'Email',
                  onChanged: context.read<CreateCodeBloc>().editEmail,
                  initialValue:
                      context.read<CreateCodeBloc>().state.email.value,
                  errorText: createCodeState.email.errorMessage,
                  textWidget: Text(
                    'A continuacion te llegara un correo con un codigo a introducir con el fin de restablecer tu contraseña ',
                    textAlign: TextAlign.justify,
                    style: theme.textTheme.bodyLarge,
                  ),
                  buttonLabel: 'Continuar',
                  onPressed: createCodeState.state == CreateCodeState.valid ||
                          createCodeState.state == CreateCodeState.success
                      ? () async {
                          await context.read<FormCubit>().formSubmit(
                                context.read<CreateCodeBloc>().submit(),
                              );
                        }
                      : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
