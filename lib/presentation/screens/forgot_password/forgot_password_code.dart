import 'package:communitary_service_app/presentation/screens/forgot_password/view_models/forgot_password_body_view_model.dart';
import 'package:communitary_service_app/presentation/screens/forgot_password/widgets/forgot_password_body.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecoverPasswordCodeScreen extends StatelessWidget {
  static const routeName = 'recover_password_code';
  const RecoverPasswordCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Codigo de recuperación'),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: FogotPasswordBody(
              viewModel: ForgotPasswordBodyViewModel(
                labelText: 'Codigo',
                onChanged: (text) {},
                errorText: null,
                textWidget: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text:
                        'Si no haz recibido el código revisa en la carpeta de spam y en caso de no recibirlo ',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'haz click aquí',
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                buttonLabel: 'Continuar',
                onPressed: () {
                  context.push('/restore_password');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
