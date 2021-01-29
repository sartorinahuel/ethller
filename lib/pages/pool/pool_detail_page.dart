import 'package:flutter/material.dart';

import 'package:ethller_api_interface/ethller_api_interface.dart';

class PoolStatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    poolRepo.updatePoolStats();
    return Scaffold(
      appBar: AppBar(title: Text('Ethermin pool stats')),
      body: StreamBuilder<PoolData>(
          stream: poolRepo.poolDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final poolData = snapshot.data;
              final poolHasRate = poolData.poolStats.hashRate / 1000000000000;
              final poolMiners = poolData.poolStats.miners;
              final poolWorkers = poolData.poolStats.workers;
              final blocksPerHour = poolData.poolStats.blocksPerHour;
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Hashrate: ${poolHasRate.toStringAsFixed(2)} TH/s',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      'Total miners: $poolMiners',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      'Total workers: $poolWorkers',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      'Blocks per hour: ${blocksPerHour.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Mined blocks:',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: poolData.minedBlocks.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _MinedBlockContainer(minedBlock: poolData.minedBlocks[index]),
                    )
                  ],
                ),
              );
            }
            return Center(child: Text('Loading...'));
          }),
    );
  }
}

class _MinedBlockContainer extends StatelessWidget {
  final MinedBlocks minedBlock;
  const _MinedBlockContainer({
    Key key,
    @required this.minedBlock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, width: double.infinity, color: Colors.white),
          SizedBox(height: 10),
          Text('Number: ${minedBlock.number}', style: Theme.of(context).textTheme.bodyText1),
          Text('Miner: ${minedBlock.miner}', style: Theme.of(context).textTheme.bodyText1),
          Text('Date: ${minedBlock.time}', style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }
}
