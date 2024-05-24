import 'package:communitary_service_app/presentation/screens/forgot_password/view_models/forgot_password_body_view_model.dart';
import 'package:communitary_service_app/presentation/screens/forgot_password/widgets/forgot_password_body.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

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
                textWidget: const Text(
                  'Si no haz recibido el codigo revisa en la carpeta de spam y en caso de no recibirlo haz click aqui',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                buttonLabel: 'Continuar',
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
