import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomCard(
                title: 'Reporte de BMI',
                subtitle: 'Mensual y Anual',
                text:
                    'Este reporte muestra el incremento del BMI mensual y anual de cada uno de los beneficiarios de la asociación.',
                icon: 'assets/icon/bmi_icon.png',
                buttonText: 'Ver mas',
                onPressed: () {
                  context.push('/charts');
                },
                size: size),
            VerticalSpacer.v22().createSpace(),
            CustomCard(
              title: 'Reporte de peso',
              subtitle: 'Mensual y Anual',
              text:
                  'Este reporte muestra el incremento del peso mensual y anual de cada uno de los beneficiarios de la asociación.',
              icon: 'assets/icon/weight_icon.png',
              onPressed: () {},
              size: size,
              buttonText: 'Ver mas',
            ),
            VerticalSpacer.v22().createSpace(),
            CustomCard(
              title: 'Reporte de altura',
              subtitle: 'Mensual y Anual',
              text:
                  'Este reporte muestra el incremento de la altura mensual y anual de cada uno de los beneficiarios de la asociación.',
              icon: 'assets/icon/height_icon.png',
              onPressed: () {},
              size: size,
              buttonText: 'Ver mas',
            ),
          ],
        ),
      ),
    );
  }
}
