import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class TripleLineChart extends StatelessWidget {
  final List<List<double>> data;
  const TripleLineChart({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FlSpot> dots = List<FlSpot>.generate(
        data[0].length, (index) => FlSpot(index.toDouble(), double.parse(data[0][index].toStringAsFixed(2))));
    List<FlSpot> dots2 = List<FlSpot>.generate(
        data[1].length, (index) => FlSpot(index.toDouble(), double.parse(data[1][index].toStringAsFixed(2))));
    List<FlSpot> dots3 = List<FlSpot>.generate(
        data[2].length, (index) => FlSpot(index.toDouble(), double.parse(data[2][index].toStringAsFixed(2))));
    return Container(
      height: 140,
      width: double.infinity,
      child: LineChart(
        LineChartData(
            backgroundColor: Color(0xFF202143),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: dots.length.toDouble(),
            minY: [...data[0], ...data[1], ...data[2]].reduce(min) - 40,
            maxY: [...data[0], ...data[1], ...data[2]].reduce(max),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.grey[600].withOpacity(0.3),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: dots,
                isCurved: true,
                colors: [Color(0xff02d39a)],
                barWidth: 1,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  colors: [Color(0xff02d39a).withOpacity(0.2)],
                ),
              ),
              LineChartBarData(
                spots: dots2,
                isCurved: true,
                colors: [Colors.purple[600]],
                barWidth: 1,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  colors: [Colors.purple[600].withOpacity(0.2)],
                ),
              ),
              LineChartBarData(
                spots: dots3,
                isCurved: true,
                colors: [Colors.blue[600]],
                barWidth: 1,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  colors: [Colors.blue[600].withOpacity(0.2)],
                ),
              ),
            ]),
      ),
    );
  }
}
