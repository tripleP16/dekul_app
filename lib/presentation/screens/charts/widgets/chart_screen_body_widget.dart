import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/download_charts_service.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_bloc.dart';
import 'package:communitary_service_app/presentation/blocs/reports/reports_state.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/line_chart_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/report_description_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/time_controller_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChartScreenBodyWidget extends StatelessWidget {
  ChartScreenBodyWidget({super.key});

  final GlobalKey _chartKey = GlobalKey();

  Future<void> _generatePdf() async {
    await getIt<DownloadChartsService>().downloadChartsPdf(
      DownloadChartModel(
        chartKey: _chartKey,
        reportTitle: 'Reporte Global',
        reportDescription: 'Reporte global de la comunidad',
        reportDate: DateTime.now().toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const TimeControllerWidget(),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<ReportsBloc, ReportsState>(
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
                  child: const LineChartWidget(),
                ),
              );
            },
          ),
          const ReportDescription(),
          const SizedBox(
            height: 20,
          ),
          CustomElevatedButton.light(
            onPressed: () {
              _generatePdf();
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
