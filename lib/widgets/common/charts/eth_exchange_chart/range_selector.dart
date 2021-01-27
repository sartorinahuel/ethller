import 'package:ethller/widgets/common/buttons/companion_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'eth_chart_provider.dart';

class RangeSelector extends StatefulWidget {
  @override
  _RangeSelectorState createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  int _selectedButton = 0;

  @override
  Widget build(BuildContext context) {
    final _ethChartProvider =
        Provider.of<EthChartProvider>(context, listen: false);

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
              // _ethChartProvider.setChange = widget.coin.changeDay;
              _ethChartProvider.selectRange = Range.OneDay;
            },
          ),
          CompanionButton(
            text: '1W',
            isSelected: _selectedButton == 1,
            onPressed: () {
              _selectedButton = 1;
              setState(() {});
              // _ethChartProvider.setChange = widget.coin.changeWeek;
              _ethChartProvider.selectRange = Range.OneWeek;
            },
          ),
          CompanionButton(
            text: '1M',
            isSelected: _selectedButton == 2,
            onPressed: () {
              _selectedButton = 2;
              setState(() {});
              // _ethChartProvider.setChange = widget.coin.changeMonth;
              _ethChartProvider.selectRange = Range.OneMonth;
            },
          ),
          CompanionButton(
            text: '1Y',
            isSelected: _selectedButton == 3,
            onPressed: () {
              _selectedButton = 3;
              setState(() {});
              // _ethChartProvider.setChange = widget.coin.changeYear;
              _ethChartProvider.selectRange = Range.OneYear;
            },
          ),
          CompanionButton(
            text: '2Y',
            isSelected: _selectedButton == 4,
            onPressed: () {
              _selectedButton = 4;
              setState(() {});
              // _ethChartProvider.setChange = widget.coin.changeFiveYears;
              _ethChartProvider.selectRange = Range.TwoYears;
            },
          ),
        ],
      ),
    );
  }
}