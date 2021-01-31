import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller/widgets/common/charts/radial_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_container.dart';

class PaymentsSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double porcentaje = 0;

    return CustomContainer(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        child: BlocBuilder<MinersBloc, MinersState>(
          builder: (context, state) {
            if (state is MinersLoadedState) {
              final unpaidBalance = (state.miner.currentStats.unpaid ?? 0);
              porcentaje = (unpaidBalance * 100) / state.miner.minPayout;
              return Row(
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
                                  unpaidBalance.toStringAsFixed(6),
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
                  CustomRadialProgress(porcentaje: double.parse(porcentaje.toStringAsFixed(2)))
                ],
              );
            }
            if (state is MinersInitial) {
              return Row(
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
                                  '0',
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
                  CustomRadialProgress(porcentaje: 0.0),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
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
                  porcentaje.toString(),
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
