import 'package:communitary_service_app/presentation/screens/charts/view_models/enums/chart_type_enum.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartViewModel {
  final ChartType type;
  final String title;
  final String description;
  final DateTime date;
  final List<List<FlSpot>> data;
  final String xTitle;
  final String yTitle;

  ChartViewModel({
    required this.type,
    required this.title,
    required this.description,
    required this.date,
    required this.data,
    required this.xTitle,
    required this.yTitle,
  });

  
}
