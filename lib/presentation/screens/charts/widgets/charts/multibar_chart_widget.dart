import 'dart:math';

import 'package:communitary_service_app/domain/models/reports/individual_reports_model.dart';
import 'package:communitary_service_app/domain/models/reports/reports_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyMultiBarChartWidget extends StatelessWidget {
  final double height;
  final List<IndividualReportsModel> individualReports;

  const MonthlyMultiBarChartWidget({
    Key? key,
    this.height = 400,
    required this.individualReports,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (individualReports.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'No hay datos para mostrar',
            style: textTheme.titleLarge,
          ),
        ),
      );
    }

    final allXValues = individualReports
        .expand((report) =>
            report.points.where((e) => e.value != null).map((point) => point.x))
        .whereType<int>()
        .where((x) => x >= 1 && x <= 12)
        .toSet()
        .toList();

    if (allXValues.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'No hay datos válidos para mostrar en el eje X',
            style: textTheme.titleLarge,
          ),
        ),
      );
    }

    allXValues.sort();

    final allYValues = individualReports
        .expand((report) => report.points.map((point) => point.value))
        .whereType<double>()
        .toList();

    if (allYValues.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'No hay datos para mostrar en el eje Y',
            style: textTheme.titleMedium,
          ),
        ),
      );
    }

    final minY = allYValues.reduce(min);
    final maxY = allYValues.reduce(max);

    // Handle the case where all values are the same
    final yInterval =
        (maxY - minY).abs() < 1e-10 ? 1.0 : _calculateInterval(minY, maxY);
    final adjustedMinY =
        minY == maxY ? minY - 1 : (minY ~/ yInterval) * yInterval;
    final adjustedMaxY =
        minY == maxY ? maxY + 1 : ((maxY / yInterval).ceil()) * yInterval;

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: yInterval,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    final monthNames = [
                      'Ene',
                      'Feb',
                      'Mar',
                      'Abr',
                      'May',
                      'Jun',
                      'Jul',
                      'Ago',
                      'Sep',
                      'Oct',
                      'Nov',
                      'Dic'
                    ];
                    final monthIndex = value.toInt() - 1;
                    if (monthIndex >= 0 && monthIndex < 12) {
                      return Text(monthNames[monthIndex], style: style);
                    }
                    return const Text('');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toStringAsFixed(0),
                      style: textTheme.labelSmall,
                    );
                  },
                  reservedSize: 40,
                  interval: yInterval,
                ),
              ),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            minY: adjustedMinY,
            maxY: adjustedMaxY,
            barGroups: _generateBarGroups(),
            groupsSpace: 12,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final report = individualReports[rodIndex];
                  final monthNames = [
                    'Enero',
                    'Febrero',
                    'Marzo',
                    'Abril',
                    'Mayo',
                    'Junio',
                    'Julio',
                    'Agosto',
                    'Septiembre',
                    'Octubre',
                    'Noviembre',
                    'Diciembre'
                  ];
                  final monthName = monthNames[group.x.toInt() - 1];
                  return BarTooltipItem(
                    '${report.name}\n$monthName: ${rod.toY.toStringAsFixed(2)}',
                    const TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    final random = Random();
    final allMonths = List.generate(12, (index) => index + 1);

    return allMonths.map((month) {
      final bars = individualReports.map((report) {
        final point = report.points.firstWhere((p) => p.x == month,
            orElse: () => ReportsModel(x: month, value: 0));
        return BarChartRodData(
          toY: point.value ?? 0,
          color: Color.fromRGBO(
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
            1,
          ),
          width: 12,
          borderRadius: BorderRadius.circular(4),
        );
      }).toList();

      return BarChartGroupData(
        x: month,
        barRods: bars,
      );
    }).toList();
  }

  double _calculateInterval(double min, double max) {
    double range = max - min;
    if (range == 0) {
      return 1.0; // Return a default interval if all values are the same
    }
    double interval = range / 5;
    return _roundToNiceInterval(interval);
  }

  double _roundToNiceInterval(double interval) {
    if (interval == 0) return 1.0; // Prevent division by zero
    final magnitude = pow(10, (log(interval) / ln10).floor());
    final niceInterval = magnitude * _roundToNice(interval / magnitude);
    return niceInterval > 0 ? niceInterval : 1.0;
  }

  double _roundToNice(double number) {
    if (number < 1.5) return 1;
    if (number < 3) return 2;
    if (number < 7) return 5;
    return 10;
  }
}
