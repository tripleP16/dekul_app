import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class BeneficiariesScreen extends StatelessWidget {
  static const routeName = 'beneficiaries';
  const BeneficiariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Beneficiaries'),
    );
  }
}
