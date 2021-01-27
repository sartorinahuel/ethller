import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';

import '../linear_chart.dart';
import 'chart_header.dart';
import 'eth_chart_provider.dart';
import 'range_selector.dart';

class ExchangeChart extends StatelessWidget {
  final String coinId;

  const ExchangeChart(this.coinId);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => EthChartProvider(),
      child: Builder(
        builder: (BuildContext context) {
          return StreamBuilder<List<CoinHistory>>(
              stream: coinHistoryRepo.oneWeekRangeCoinHistoriesListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // final testProv =
                  //     Provider.of<EthChartProvider>(context).rangeName;
                  // print(testProv);
                  List<double> chartValues = [];
                  var data = snapshot.data;
                  // Filter selected coin´s histories
                  for (var ch in data) {
                    if (ch.coinId == coinId) {
                      chartValues.add(ch.price);
                      // print(ch.date);
                    }
                  }
                  // print(chartValues.length);
                  return ChartBox(chartValues);
                }
                return Center(child: CircularProgressIndicator());
              });
        },
      ),
    );
  }
}

class ChartBox extends StatelessWidget {
  final List<double> chartValues;

  const ChartBox(this.chartValues);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF202143),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      //TODO connect with stream
      child: 1 != 0.0
          ? Column(
              children: [
                ChartHeader(),
                SizedBox(height: 10),
                //TODO connect with stream
                Chart(
                  data: [...chartValues],
                  color: const Color(0xff02d39a),
                ),
                RangeSelector()
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
