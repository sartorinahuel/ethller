import 'package:ethller/widgets/common/buttons/companion_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chart_bloc.dart';

class RangeSelector extends StatefulWidget {
  @override
  _RangeSelectorState createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  int _selectedButton = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _ethChartBloc = BlocProvider.of<ChartBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 30, right: 30, bottom: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CompanionButton(
            text: '1D',
            isSelected: _selectedButton == 0,
            onPressed: () {
              _selectedButton = 0;
              setState(() {});
              _ethChartBloc.add(ChartOneDayPeriodEvent());
            },
          ),
          CompanionButton(
            text: '1W',
            isSelected: _selectedButton == 1,
            onPressed: () {
              _selectedButton = 1;
              setState(() {});
              _ethChartBloc.add(ChartOneWeekPeriodEvent());
            },
          ),
          CompanionButton(
            text: '1M',
            isSelected: _selectedButton == 2,
            onPressed: () {
              _selectedButton = 2;
              setState(() {});
              _ethChartBloc.add(ChartOneMonthPeriodEvent());
            },
          ),
          CompanionButton(
            text: '1Y',
            isSelected: _selectedButton == 3,
            onPressed: () {
              _selectedButton = 3;
              setState(() {});
              _ethChartBloc.add(ChartOneYearPeriodEvent());
            },
          ),
          CompanionButton(
            text: '5Y',
            isSelected: _selectedButton == 4,
            onPressed: () {
              _selectedButton = 4;
              setState(() {});
              _ethChartBloc.add(ChartFiveYearsPeriodEvent());
            },
          ),
        ],
      ),
    );
  }
}
