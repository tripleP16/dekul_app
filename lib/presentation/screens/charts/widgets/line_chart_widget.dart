import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final double height;
  final List<FlSpot> spots;
  final List<int> xValues;
  final List<double> yValues;
  final Color color;
  const LineChartWidget({
    super.key,
    this.height = 400,
    required this.spots,
    required this.xValues,
    required this.yValues,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final maxX = (xValues.length - 1).toDouble(); // Doubled to widen the scale

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  interval: 10, // Adjusted for wider scale
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    final index = value ~/ 2; // Integer division by 2
                    if (index >= 0 &&
                        index < xValues.length &&
                        index % 5 == 0) {
                      return Text(xValues[index].toString(), style: style);
                    }
                    return const Text('');
                  },
                ),
                axisNameWidget: const Text('Tiempo'),
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
                  reservedSize: 22,
                  interval: (yValues.reduce((a, b) => a > b ? a : b) -
                          yValues.reduce((a, b) => a < b ? a : b)) /
                      5,
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
            minX: 0,
            maxX: maxX,
            minY: yValues.reduce((a, b) => a < b ? a : b),
            maxY: yValues.reduce((a, b) => a > b ? a : b),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(xValues.length,
                    (index) => FlSpot(index * 2.0, yValues[index])),
                isCurved: true,
                color: color,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
