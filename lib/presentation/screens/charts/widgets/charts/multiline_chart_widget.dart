import 'dart:math';

import 'package:communitary_service_app/domain/models/reports/individual_reports_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MultiLineChartWidget extends StatelessWidget {
  final double height;
  final List<IndividualReportsModel> individualReports;

  const MultiLineChartWidget({
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
        .expand((report) => report.points.map((point) => point.x))
        .whereType<int>()
        .toList();

    if (allXValues.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'No hay datos para mostrar en el eje X',
            style: textTheme.titleLarge,
          ),
        ),
      );
    }

    allXValues.sort();
    final maxX = allXValues.last.toDouble();
    final minX = allXValues.first.toDouble();
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

    final yInterval = _calculateInterval(minY, maxY);
    final adjustedMinY = (minY ~/ yInterval) * yInterval;
    final adjustedMaxY = ((maxY / yInterval).ceil()) * yInterval;

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
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
                  reservedSize: 22,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    if (allXValues.contains(value.toInt())) {
                      return Text(value.toInt().toString(), style: style);
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
            minX: minX,
            maxX: maxX,
            minY: adjustedMinY,
            maxY: adjustedMaxY,
            lineBarsData: _generateLineBarsData(),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    final flSpot = barSpot;
                    final report = individualReports[barSpot.barIndex];
                    return LineTooltipItem(
                      '${report.name}\n${flSpot.y.toStringAsFixed(2)}',
                      const TextStyle(color: Colors.white),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<LineChartBarData> _generateLineBarsData() {
    final random = Random();
    return List.generate(
      individualReports.length,
      (index) {
        final report = individualReports[index];
        return LineChartBarData(
          spots: report.points
              .where((point) => point.value != null)
              .map((point) => FlSpot(point.x.toDouble(), point.value!))
              .toList(),
          isCurved: true,
          color: Color.fromRGBO(
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
            1,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
        );
      },
    );
  }

  double _calculateInterval(double min, double max) {
    double range = max - min;
    double interval = range / 5;
    return _roundToNiceInterval(interval);
  }

  double _roundToNiceInterval(double interval) {
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
