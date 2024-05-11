import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _LoginScreenBody());
  }
}

class _LoginScreenBody extends StatelessWidget {
  const _LoginScreenBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 70),
                child: const MainLogoWidget(
                  size: Size(200, 200),
                ),
              ),
              VerticalSpacer.v34().createSpace(),
              CustomElevatedButton.light(
                onPressed: () {
                  context.push('/login_form');
                },
                text: 'Iniciar sesión',
                elevation: 2.0,
                width: 70,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
