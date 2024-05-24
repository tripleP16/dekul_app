import 'package:communitary_service_app/presentation/shared/widgets/forms/inputs/text_input.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ForgotPasswordEmail extends StatelessWidget {
  static const String routeName = 'forgot_password_email';
  const ForgotPasswordEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Recuperacion de contraseña'),
      body: Padding(
        padding: EdgeInsets.all(35.0),
        child: Center(
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: _FormPasswordEmailBody(),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormPasswordEmailBody extends StatelessWidget {
  const _FormPasswordEmailBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 1,
        ),
        TextInputWidget(
          labelText: 'Email',
          onChanged: (text) {},
        ),
        const Spacer(
          flex: 1,
        ),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            'A continuacion te llegara un correo con un codigo a introducir con el fin de restablecer tu contraseña ',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 18),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        CustomElevatedButton.light(
          onPressed: () {},
          text: 'Continuar',
          elevation: 3,
          width: 80,
          height: 20,
        ),
      ],
    );
  }
}
