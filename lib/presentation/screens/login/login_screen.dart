import 'package:communitary_service_app/presentation/screens/login/login_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio de Sesión"),
        leading: const Icon(Icons.arrow_back),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginForm(
              seed: Random(),
            )
          ],
        ),
      ),
    );
  }
}
