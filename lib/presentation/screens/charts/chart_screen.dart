import 'package:communitary_service_app/config/helpers/locator.dart';
import 'package:communitary_service_app/config/services/contracts/download_charts_service.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/line_chart_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/report_description_widget.dart';
import 'package:communitary_service_app/presentation/screens/charts/widgets/time_controller_widget.dart';
import 'package:communitary_service_app/presentation/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChartScreen extends StatefulWidget {
  static const String routeName = 'chart_screen';
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Reporte Global'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: SingleChildScrollView(
            child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              const TimeControllerWidget(),
              Center(
                child: RepaintBoundary(
                  key: _chartKey,
                  child: const LineChartWidget(),
                ),
              ),
              const ReportDescription(),
              const Spacer(
                flex: 1,
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
              const Spacer(
                flex: 1,
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
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
