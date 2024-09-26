import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/download_charts_service.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_state.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/charts/bar_chart_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/charts/line_chart_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/report_description_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/time_controller_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChartScreenBodyWidget extends StatefulWidget {
  const ChartScreenBodyWidget({super.key});

  @override
  State<ChartScreenBodyWidget> createState() => _ChartScreenBodyWidgetState();
}

class _ChartScreenBodyWidgetState extends State<ChartScreenBodyWidget> {
  final GlobalKey _chartKey = GlobalKey();

  bool isLoadingReport = false;

  Future<void> _generatePdf(
    String title,
    String description,
  ) async {
    await getIt<DownloadChartsService>().downloadChartsPdf(
      DownloadChartModel(
        chartKey: _chartKey,
        reportTitle: title,
        reportDescription: description,
        reportDate: DateTime.now().toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<ReportsBloc>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          TimeControllerWidget(
            onAnualPressed: state.isAnual
                ? null
                : () {
                    context.read<ReportsBloc>().loadReport(
                        state.query.copyWith(isYearly: true), null, null, null);
                  },
            onMonthlyPressed: state.isMonthly
                ? null
                : () {
                    context.read<ReportsBloc>().loadReport(
                        state.query.copyWith(isYearly: false),
                        null,
                        null,
                        null);
                  },
          ),
          const SizedBox(
            height: 20,
          ),
          _Chart(
            theme: theme,
            chartKey: _chartKey,
          ),
          ReportDescription(
            title: state.title,
            text: state.text,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomElevatedButton.light(
            onPressed: isLoadingReport
                ? null
                : () async {
                    setState(() {
                      isLoadingReport = true;
                    });
                    await _generatePdf(
                      state.title,
                      state.text,
                    );

                    setState(() {
                      isLoadingReport = false;
                    });
                  },
            text: 'Descargar',
            elevation: 2,
            width: 50,
            height: 15,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomElevatedButton.dark(
            onPressed: () {
              context.read<ReportsBloc>().loadIndividualReport(
                  state.query.copyWith(
                    userIds: () => [state.beneficiaries.data.first.id],
                  ),
                  null,
                  null,
                  null);
              context.push('/chart/individual');
            },
            text: 'Ir a reportes individuales',
            elevation: 2,
            width: 30,
            height: 15,
          ),
          const SizedBox(
            height: 50,
          )
        ],
      )),
    );
  }
}

class _Chart extends StatelessWidget {
  const _Chart({
    required this.theme,
    required GlobalKey<State<StatefulWidget>> chartKey,
  }) : _chartKey = chartKey;

  final ThemeData theme;
  final GlobalKey<State<StatefulWidget>> _chartKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.isError) {
          return Center(
            child: Text(
              state.errorMessage ?? 'Error al cargar el reporte',
              style: theme.textTheme.bodyMedium,
            ),
          );
        }
        return Center(
          child: RepaintBoundary(
            key: _chartKey,
            child: state.isAnual
                ? LineChartWidget(
                    spots: state.spots,
                    xValues: state.xValues,
                    yValues: state.yValues,
                    color: state.color,
                  )
                : MonthlyBarChartWidget(
                    yValues: state.yValues,
                    color: state.color,
                  ),
          ),
        );
      },
    );
  }
}
