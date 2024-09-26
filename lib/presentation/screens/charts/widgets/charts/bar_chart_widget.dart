import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyBarChartWidget extends StatelessWidget {
  final double height;
  final List<double> yValues;
  final Color color;

  const MonthlyBarChartWidget({
    super.key,
    this.height = 400,
    required this.yValues,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Calculate the min and max y values
    final minY = yValues.reduce(math.min);
    final maxY = yValues.reduce(math.max);

    // Calculate the y-axis interval (e.g., 5, 10, 20, etc.)
    final range = maxY - minY;
    final interval = calculateInterval(range);

    // Round down the minY and up the maxY to the nearest interval
    final adjustedMinY = (minY / interval).floor() * interval;
    final adjustedMaxY = ((maxY / interval).ceil() + 1) * interval;

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: interval,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey[300],
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    final monthNames = [
                      'Jan',
                      'Feb',
                      'Mar',
                      'Apr',
                      'May',
                      'Jun',
                      'Jul',
                      'Aug',
                      'Sep',
                      'Oct',
                      'Nov',
                      'Dec'
                    ];
                    final index = value.toInt();
                    if (index >= 0 && index < 12) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(monthNames[index], style: style),
                      );
                    }
                    return const Text('');
                  },
                ),
                axisNameWidget: const Text('Months'),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()}',
                      style: textTheme.labelSmall,
                    );
                  },
                  reservedSize: 40,
                  interval: interval,
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
            barGroups: List.generate(12, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: yValues[index],
                    color: color,
                    width: 16,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                ],
              );
            }),
            minY: adjustedMinY,
            maxY: adjustedMaxY,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    rod.toY.toStringAsFixed(2),
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

  double calculateInterval(double range) {
    final magnitude = range.toInt().toString().length - 1;
    final normalized = range / math.pow(10, magnitude);
    double interval;

    if (normalized <= 1.5) {
      interval = 1;
    } else if (normalized <= 3) {
      interval = 2;
    } else if (normalized <= 7) {
      interval = 5;
    } else {
      interval = 10;
    }

    return interval * math.pow(10, magnitude);
  }
}
