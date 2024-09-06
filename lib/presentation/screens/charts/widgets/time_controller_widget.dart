import 'package:communitary_service_app/presentation/blocs/reports/reports_bloc.dart';
import 'package:communitary_service_app/presentation/shared/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeControllerWidget extends StatelessWidget {
  const TimeControllerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReportsBloc>().state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomOutlinedButton(
          onPressed: state.isAnual
              ? null
              : () {
                  context.read<ReportsBloc>().loadReport(
                      state.query.copyWith(isYearly: true), null, null, null);
                },
          icon: Icons.auto_graph_outlined,
          text: 'Anual',
        ),
        CustomOutlinedButton(
          onPressed: state.isMonthly
              ? null
              : () {
                  context.read<ReportsBloc>().loadReport(
                      state.query.copyWith(isYearly: false), null, null, null);
                },
          icon: Icons.calendar_month,
          text: 'Mensual',
        ),
      ],
    );
  }
}
