import 'package:communitary_service_app/presentation/blocs/forgot_password/create_code_bloc/create_code_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/forgot_password/restore_password/reset_password_bloc.dart';
import 'package:communitary_service_app/presentation/shared/blocs/forms_state_cubit/forms_cubit.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:communitary_service_app/presentation/shared/widgets/forms/wrappers/form_wrapper.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = 'forgot_password_screen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late CreateCodeBloc _codeBloc;
  late ResetPasswordBloc _resetPasswordBloc;

  @override
  void initState() {
    super.initState();
    _codeBloc = BlocProvider.of<CreateCodeBloc>(context);
    _resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final resetPasswordState = context.watch<ResetPasswordBloc>();
    final resetPasswordBloc = context.read<ResetPasswordBloc>();
    return PopScope(
      onPopInvoked: (didPop) {
        resetPasswordBloc.reset();
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Restablecer contraseña'),
        body: Padding(
          padding: const EdgeInsets.all(36),
          child: Center(
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                TextInputWidget(
                  labelText: 'Nueva Contraseña',
                  initialValue: resetPasswordBloc.state.password.value,
                  onChanged: resetPasswordBloc.editPassword,
                  errorText: resetPasswordState.state.password.errorMessage,
                  obscureText: true,
                ),
                const Spacer(
                  flex: 1,
                ),
                TextInputWidget(
                  labelText: 'Repite la nueva Contraseña',
                  initialValue: resetPasswordBloc.state.confirmPassword.value,
                  errorText: _getErrorText(resetPasswordState),
                  onChanged: resetPasswordBloc.editConfirmPassword,
                  obscureText: true,
                ),
                const Spacer(
                  flex: 2,
                ),
                FormWrapper(
                  successContent: 'La contraseña ha sido restablecida',
                  child: CustomElevatedButton.dark(
                    onPressed: resetPasswordState.state.isValid
                        ? () async {
                            await context
                                .read<FormCubit>()
                                .formSubmit(resetPasswordBloc.submit());

                            _codeBloc.reset();
                            _resetPasswordBloc.reset();
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
        ),
      ),
    );
  }

  _getErrorText(ResetPasswordBloc resetPasswordState) {
    if (resetPasswordState.state.confirmPassword.errorMessage != null) {
      return resetPasswordState.state.confirmPassword.errorMessage;
    }
    if (resetPasswordState.state.password.value !=
        resetPasswordState.state.confirmPassword.value) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }
}
