import 'package:communitary_service_app/domain/models/reports/reports_query_model.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_bloc.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: _ReportsPageBody(),
    );
  }
}

class _ReportsPageBody extends StatelessWidget {
  const _ReportsPageBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomCard(
                color: Colors.green,
                title: 'Reporte de BMI',
                subtitle: 'Mensual y Anual',
                icon: 'assets/icon/bmi_icon.png',
                onPressed: () {
                  context.read<ReportsBloc>().loadReport(
                        ReportsQueryModel(
                          reportType: ReportType.bmi,
                          isYearly: true,
                        ),
                        Colors.green,
                        'Reporte de BMI',
                        'Este reporte muestra el incremento del BMI mensual y anual de cada uno de los beneficiarios de la asociación.',
                      );
                  context.push('/charts');
                },
                size: size),
            VerticalSpacer.v22().createSpace(),
            CustomCard(
              color: Colors.blue,
              title: 'Reporte de peso',
              subtitle: 'Mensual y Anual',
              icon: 'assets/icon/weight_icon.png',
              onPressed: () {
                context.read<ReportsBloc>().loadReport(
                      ReportsQueryModel(
                        reportType: ReportType.weight,
                        isYearly: true,
                      ),
                      Colors.blue,
                      'Reporte de peso',
                      'Este reporte muestra el incremento del peso mensual y anual de cada uno de los beneficiarios de la asociación.',
                    );
                context.push('/charts');
              },
              size: size,
            ),
            VerticalSpacer.v22().createSpace(),
            CustomCard(
              color: Colors.orange,
              title: 'Reporte de altura',
              subtitle: 'Mensual y Anual',
              icon: 'assets/icon/height_icon.png',
              onPressed: () {
                context.read<ReportsBloc>().loadReport(
                      ReportsQueryModel(
                        reportType: ReportType.height,
                        isYearly: true,
                      ),
                      Colors.orange,
                      'Reporte de altura',
                      'Este reporte muestra el incremento de la altura mensual y anual de cada uno de los beneficiarios de la asociación.',
                    );
                context.push('/charts');
              },
              size: size,
            ),
          ],
        ),
      ),
    );
  }
}
