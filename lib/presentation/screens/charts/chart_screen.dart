import 'package:communitary_service_app/presentation/screens/charts/widgets/chart_screen_body_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  static const String routeName = 'chart_screen';
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Reporte Global'),
      body: ChartScreenBodyWidget(),
    );
  }
}
