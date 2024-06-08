import 'package:communitary_service_app/presentation/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RegisterParentScreen extends StatelessWidget {
  static const routeName = 'register_parent';
  const RegisterParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Representante',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
