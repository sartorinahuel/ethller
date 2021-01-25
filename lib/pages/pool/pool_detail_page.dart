import 'package:flutter/material.dart';

import 'package:ethller_api_interface/ethller_api_interface.dart';

class PoolStatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    poolRepo.updatePoolStats();
    return StreamBuilder<PoolData>(
        stream: poolRepo.poolDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
          final poolData = snapshot.data;
          final poolHasRate = poolData.poolStats.hashRate / 1000000000000;
            return Scaffold(
              appBar: AppBar(title: Text('Ethermin pool stats')),
              body: Center(child: Text('Total Hashrate: ${poolHasRate.toStringAsFixed(2)} TH/s')),
            );
          }
          return Scaffold(
            appBar: AppBar(title: Text('Ethermin pool stats')),
            body: Center(child: Text('Loading...')),
          );
        });
  }
}