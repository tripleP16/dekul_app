import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/forms.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = 'forgot_password_screen';
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onChanged: (password) {},
              ),
              const Spacer(
                flex: 1,
              ),
              TextInputWidget(
                  labelText: 'Repite la nueva Contraseña',
                  onChanged: (password) {}),
              const Spacer(
                flex: 2,
              ),
              CustomElevatedButton.dark(
                onPressed: () {},
                text: 'Continuar',
                elevation: 3,
                width: 80,
                height: 20,
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
