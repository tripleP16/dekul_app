import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterBeneficiaryPage extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const RegisterBeneficiaryPage({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        actions: actions,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: child,
        ),
      ),
    );
  }
}
