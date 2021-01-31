import 'package:ethller/widgets/common/charts/eth_exchange_chart/bloc/chart_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../linear_chart.dart';
import 'chart_header.dart';
import 'range_selector.dart';

class ExchangeChart extends StatelessWidget {
  final String coinId;

  const ExchangeChart({Key key, this.coinId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ChartBox(coinId);
  }
}

class _ChartBox extends StatelessWidget {
  final String coinId;

  const _ChartBox(this.coinId);

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
      child: BlocBuilder<ChartBloc, ChartBlocState>(
        builder: (BuildContext context, state) {
          if (state is ChartDataState) {
            final double avgChange =
                (state.chartValues.last - state.chartValues.first) *
                    100 /
                    state.chartValues.first;
            return Column(
              children: [
                ChartHeader(
                    coinId: coinId,
                    price: state.chartValues.last,
                    activeChange: avgChange),
                SizedBox(height: 10),
                Chart(
                  data: state.chartValues,
                  color: const Color(0xff02d39a),
                ),
                RangeSelector(),
              ],
            );
          }

          if (state is ChartNoConnectionState) {
            return Center(child: Text('No internet connection'));
          }

          if (state is ChartErrorState) {
            return Center(child: Text(state.appError.message));
          }
          
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
