import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller/widgets/common/charts/radial_progress.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_container.dart';

class PaymentsSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 240,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        child: BlocBuilder<MinersBloc, MinersState>(
          builder: (context, state) {
            if (state is MinersLoadedState) {
              return _PaymentSummaryItem(miner: state.miner);
            }

            if (state is MinersInitial) {
              return _PaymentSummaryItem();
            }

            if (state is MinersWalletNotFoundState) {
              return Center(child: Text('Couldn´t find wallet in Ethermine pool'));
            }

            if (state is MinersNoConnectionState) {
              return Center(child: Text('No connection'));
            }

            if (state is MinersErrorState) {
              return Center(child: Text(state.appError.message));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _PaymentSummaryItem extends StatelessWidget {
  final Miner miner;

  const _PaymentSummaryItem({
    Key key,
    this.miner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double unpaidBalance = 0;
    double porcentaje = 0;
    double usdPerMin = 0;
    double btcPerMin = 0;
    if (miner != null) {
      unpaidBalance = (miner.currentStats?.unpaid ?? 0);
      porcentaje = (unpaidBalance * 100) / miner.minPayout;
      usdPerMin = miner.currentStats.usdPerMin;
      btcPerMin = miner.currentStats.btcPerMin;
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.payments,
                      color: Colors.grey[600],
                      size: 30,
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Payments',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Unpaid Balance',
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            unpaidBalance.toStringAsFixed(5),
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          Text(
                            ' ETH',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            CustomRadialProgress(porcentaje: porcentaje),
          ],
        ),
        SizedBox(height: 10),
        Container(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('USD:', style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 20)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Day: '),
                      Text(
                        '\$${(usdPerMin * 1440).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Color(0xff02d39a),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Week: '),
                      Text(
                        '\$${(usdPerMin * 10080).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Color(0xff02d39a),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Month: '),
                      Text(
                        '\$${(usdPerMin * 43200).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Color(0xff02d39a),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BTC:', style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 20)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Day: '),
                      Text('${(btcPerMin * 1440).toStringAsFixed(5)}'),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Week: '),
                      Text('${(btcPerMin * 10080).toStringAsFixed(5)}'),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('Month: '),
                      Text('${(btcPerMin * 43200).toStringAsFixed(5)}'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  const CustomRadialProgress({@required this.porcentaje});

  final double porcentaje;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  porcentaje.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  ' %',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          RadialProgress(
            porcentaje: porcentaje,
            colorPrimario: Color(0xff02d39a),
            colorSecundario: Colors.grey[600],
            grosorPrimario: 8,
            grosorSecundario: 2,
          ),
        ],
      ),
    );
  }
}
