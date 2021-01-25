import 'package:ethller/widgets/common/buttons/plain_button.dart';
import 'package:ethller/widgets/common/charts/radial_progress.dart';
import 'package:ethller/widgets/common/other/spinner.dart';
import 'package:flutter/material.dart';

import 'package:ethller_api_interface/ethller_api_interface.dart';

import 'package:ethller/pages/pool/pool_detail_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CoinHistory>>(
        stream: coinHistoryRepo.coinHistoriesStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CoinHistory> bitconHistory = [];
            snapshot.data.forEach((ch) {
              if (ch.coinId == 'Qwsogvtv82FCd') {
                bitconHistory.add(ch);
              }
            });
            bitconHistory.sort((a, b) => a.date.compareTo(b.date));

            return Scaffold(
              appBar: AppBar(title: Text('Ethller')),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'El precio del BITCOIN es \$${bitconHistory.last.price.toStringAsFixed(2)}'),
                  SizedBox(height: 40, width: double.infinity),
                  PlainButton(
                    height: 44,
                    width: 200,
                    title: 'Pool Stats',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => PoolStatsPage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40, width: double.infinity),
                  SpinnerIndicator(denominator: 2, numerator: 2, radius: 100),
                ],
              ),
            );
          }

          return Scaffold(body: Center(child: Text('Loading...')));
        });
  }
}
