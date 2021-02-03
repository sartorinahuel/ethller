import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller/widgets/common/other/custom_container.dart';
import 'package:ethller/widgets/common/other/spinner.dart';
import 'package:ethller/widgets/common/other/workers/workers_chart.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkersSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MinersBloc, MinersState>(
      builder: (BuildContext context, state) {
        if (state is MinersLoadedState) {
          return _MinersSummaryData(miner: state.miner);
        }

        if (state is MinersInitial) {
          return _MinersSummaryData();
        }

        if (state is MinersErrorState) {
          return CustomContainer(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(state.appError.message),
              ),
            ),
          );
        }

        return CustomContainer(child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class _MinersSummaryData extends StatelessWidget {
  final Miner miner;

  _MinersSummaryData({
    Key key,
    this.miner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int denominator;
    int numerator;
    double currentHashrate;
    double reportedHashrate;
    double averageHashrate;
    List<double> currentHashValues = [];
    List<double> reportedHashValues = [];
    List<double> averageHashValues = [];

    if (miner == null) {
      denominator = 0;
      numerator = 0;
      currentHashrate = 0;
      reportedHashrate = 0;
      averageHashrate = 0;
      currentHashValues = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
      reportedHashValues = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
      averageHashValues = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    } else {
      for (var item in miner.history) {
        currentHashValues.add(item.currentHashrate);
        reportedHashValues.add(item.reportedHashrate);
        averageHashValues.add(item.averageHashrate);
      }
      denominator = miner.currentStats.activeWorkers;
      numerator = miner.history.last.activeWorkers;
      currentHashrate = miner.currentStats.currentHashrate;
      reportedHashrate = miner.currentStats.reportedHashrate;
      averageHashrate = miner.currentStats.averageHashrate;
    }

    return CustomContainer(
      height: miner != null ? 315 : 180,
      child: Stack(
        children: [
          Column(
            children: [
              _Header(denominator: denominator, numerator: numerator),
              SizedBox(height: 5),
              _HashReportRow(
                hashRate: currentHashrate,
                title: 'Current Hashrate',
                color: Colors.green[600],
              ),
              _HashReportRow(
                hashRate: reportedHashrate,
                title: 'Reported Hashrate',
                color: Colors.purple[600],
              ),
              _HashReportRow(
                hashRate: averageHashrate,
                title: 'Average Hashrate',
                color: Colors.blue[600],
              ),
            ],
          ),
          if (miner != null)
            Container(
              height: 315,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Column(
                  children: [
                    SizedBox(height: 165),
                    TripleLineChart(
                      data: [
                        currentHashValues,
                        reportedHashValues,
                        averageHashValues,
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HashReportRow extends StatelessWidget {
  final double hashRate;
  final String title;
  final Color color;

  const _HashReportRow({
    Key key,
    @required this.hashRate,
    this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          Spacer(),
          Text(
            hashRate > 1000 ? (hashRate / 1000).toStringAsFixed(3) : hashRate.toStringAsFixed(2),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            hashRate > 1000 ? ' GH/s' : ' MH/s',
            style: TextStyle(color: Colors.grey[300], fontSize: 11),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key key,
    @required this.denominator,
    @required this.numerator,
  }) : super(key: key);

  final int denominator;
  final int numerator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 15),
      child: Row(
        children: [
          Image.asset(
            'assets/imgs/noun_miner_42900.png',
            color: Colors.grey[600],
            width: 30,
            height: 30,
          ),
          SizedBox(width: 15),
          Text(
            'Workers',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Spacer(),
          SpinnerIndicator(
            key: UniqueKey(),
            denominator: denominator,
            numerator: numerator,
          ),
        ],
      ),
    );
  }
}
