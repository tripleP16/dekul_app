import 'package:communitary_service_app/presentation/blocs/reports/reports_bloc.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/chart_screen_body_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartScreen extends StatelessWidget {
  static const String routeName = 'chart_screen';
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReportsBloc>().state;
    return Scaffold(
      appBar: CustomAppBar(title: state.title),
      body: const ChartScreenBodyWidget(),
    );
  }
}
