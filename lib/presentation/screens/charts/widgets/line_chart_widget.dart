import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final double height;

  const LineChartWidget({super.key, this.height = 400});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
                    String text;
                    switch (value.toInt()) {
                      case 0:
                        text = 'JAN';
                        break;
                      case 3:
                        text = 'APR';
                        break;
                      case 6:
                        text = 'JUL';
                        break;
                      case 9:
                        text = 'OCT';
                        break;
                      default:
                        return Container();
                    }
                    return Text(text, style: style);
                  },
                ),
                axisNameWidget: const Text(
                  'Tiempo',
                ),
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
                  interval: 5,
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
            maxX: 11,
            minY: 0,
            maxY: 40,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 40.5),
                  const FlSpot(1, 20.7),
                  const FlSpot(2, 21.2),
                  const FlSpot(3, 21.4),
                  const FlSpot(4, 21.8),
                  const FlSpot(5, 22.1),
                  const FlSpot(6, 22.3),
                  const FlSpot(7, 22.5),
                  const FlSpot(8, 22.7),
                  const FlSpot(9, 22.9),
                  const FlSpot(10, 23.1),
                  const FlSpot(11, 23.3),
                ],
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: [
                  const FlSpot(0, 22.5),
                  const FlSpot(1, 28.7),
                  const FlSpot(2, 29.2),
                  const FlSpot(3, 24.4),
                  const FlSpot(4, 29.8),
                  const FlSpot(5, 29.1),
                  const FlSpot(6, 22.3),
                  const FlSpot(7, 27.5),
                  const FlSpot(8, 22.7),
                  const FlSpot(9, 22.9),
                  const FlSpot(10, 23.1),
                  const FlSpot(11, 23.3),
                ],
                isCurved: true,
                color: Colors.red,
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
