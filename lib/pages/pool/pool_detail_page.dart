import 'package:ethller/pages/pool/bloc/pool_bloc.dart';
import 'package:ethller/widgets/common/other/custom_container.dart';
import 'package:flutter/material.dart';

import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PoolStatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ethermin pool stats')),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocBuilder<PoolBloc, PoolState>(
          builder: (context, state) {
            if (state is PoolLoadedState) {
              final poolData = state.poolData;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PoolStatsContainer(poolData: poolData.poolStats),
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
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _PoolStatsContainer extends StatelessWidget {
  const _PoolStatsContainer({
    Key key,
    @required this.poolData,
  }) : super(key: key);

  final PoolStats poolData;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Text(
            'Total Hashrate: ${poolData.hashRate.toStringAsFixed(2)} TH/s',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            'Total miners: ${poolData.miners}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            'Total workers: ${poolData.workers}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            'Blocks per hour: ${poolData.blocksPerHour.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
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
