import 'package:flutter/material.dart';

import 'package:ethller_api_interface/ethller_api_interface.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    coinHistoryRepo.getCoinHistoriesList();

    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

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
              body: Center(
                  child: Column(
                children: [
                  Text(
                      'El precio del BITCOIN es \$${bitconHistory.last.price.toStringAsFixed(2)}'),
                  SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => PoolStatsPage(),
                          ),
                        );
                      },
                      child: Text('Pool Stats'))
                ],
              )),
            );
          }

          return Scaffold(body: Center(child: Text('Loading...')));
        });
  }
}

class PoolStatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    poolRepo.updatePoolStats();
    return StreamBuilder<PoolData>(
        stream: poolRepo.poolDataStream,
        builder: (context, snapshot) {
          final poolData = snapshot.data;
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(title: Text('Ethermin pool stats')),
              body: Center(
                  child:
                      Text('Total Hashrate: ${poolData.poolStats.hashRate}')),
            );
          }
          return Scaffold(
            appBar: AppBar(title: Text('Ethermin pool stats')),
            body: Center(child: Text('Loading...')),
          );
        });
  }
}
