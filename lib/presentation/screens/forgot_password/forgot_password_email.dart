import 'package:communitary_service_app/presentation/screens/forgot_password/view_models/forgot_password_body_view_model.dart';
import 'package:communitary_service_app/presentation/screens/forgot_password/widgets/forgot_password_body.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordEmail extends StatelessWidget {
  static const String routeName = 'forgot_password_email';
  const ForgotPasswordEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Recuperacion de contraseña'),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: FogotPasswordBody(
              viewModel: ForgotPasswordBodyViewModel(
                labelText: 'Email',
                onChanged: (text) {},
                errorText: null,
                textWidget: const Text(
                  'A continuacion te llegara un correo con un codigo a introducir con el fin de restablecer tu contraseña ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                buttonLabel: 'Continuar',
                onPressed: () {
                  context.push('/forgot_password/code');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
