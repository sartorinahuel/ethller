import 'dart:math';

import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class Chart extends StatelessWidget {
  final Color color;
  final List<double> data;
  const Chart({
    Key key,
    @required this.color,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FlSpot> dots = List<FlSpot>.generate(
        data.length, (index) => FlSpot(index.toDouble(), data[index]));
    final reducer = dots.length.toDouble() > 182 ? 20 : 10;
    return Container(
      height: 145,
      width: double.infinity,
      child: LineChart(
        LineChartData(
            backgroundColor: Color(0xFF202143),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: dots.length.toDouble() + reducer,
            minY: data.reduce(min),
            maxY: data.reduce(max),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.grey[600].withOpacity(0.3),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: dots,
                isCurved: true,
                colors: [color],
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
            ]),
      ),
    );
  }
}
