import 'package:communitary_service_app/presentation/blocs/forgot_password/validate_code_bloc/validate_code_bloc.dart';
import 'package:communitary_service_app/presentation/screens/forgot_password/view_models/forgot_password_body_view_model.dart';
import 'package:communitary_service_app/presentation/screens/forgot_password/widgets/forgot_password_body.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_app_bar.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/wrappers/form_wrapper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecoverPasswordCodeScreen extends StatefulWidget {
  static const routeName = 'recover_password_code';
  const RecoverPasswordCodeScreen({super.key});

  @override
  State<RecoverPasswordCodeScreen> createState() =>
      _RecoverPasswordCodeScreenState();
}

class _RecoverPasswordCodeScreenState extends State<RecoverPasswordCodeScreen> {
  late ValidateCodeBloc _validateCodeBloc;

  @override
  void initState() {
    super.initState();
    _validateCodeBloc = BlocProvider.of<ValidateCodeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final validateCodeState = context.watch<ValidateCodeBloc>().state;
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<ValidateCodeBloc>().reset();
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Codigo de recuperación'),
        body: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: FormWrapper(
                successContent:
                    'Codigo de recuperacion validado, dispones de 30 min para restablecer tu contraseña',
                child: FogotPasswordBody(
                  viewModel: ForgotPasswordBodyViewModel(
                    initialValue:
                        context.read<ValidateCodeBloc>().state.code.value,
                    labelText: 'Codigo',
                    onChanged: context.read<ValidateCodeBloc>().onEditCode,
                    errorText: validateCodeState.code.errorMessage,
                    textWidget: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text:
                            'Si no haz recibido el código revisa en la carpeta de spam y en caso de no recibirlo ',
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'haz click aquí',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pop();
                              },
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    buttonLabel: 'Continuar',
                    onPressed: validateCodeState.isValid
                        ? () async {
                            await context.read<FormCubit>().formSubmit(context
                                .read<ValidateCodeBloc>()
                                .validateCode());

                            _validateCodeBloc.reset();
                          }
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
