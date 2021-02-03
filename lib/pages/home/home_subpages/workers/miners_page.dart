import 'package:animate_do/animate_do.dart';
import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller/widgets/common/other/custom_container.dart';
import 'package:ethller/widgets/common/other/spinner.dart';
import 'package:ethller/widgets/common/other/workers_summary.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MinersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //============================Refresh Function=======================
    Future<void> _onRefresh() async {
      if (walletUID != '') {
        BlocProvider.of<MinersBloc>(context).add(MinersInitEvent(walletUID));
      }
      await Future.delayed(Duration(seconds: 1));
      print('Done Update');
    }
    //============================Refresh Function=======================

    final size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: 165 + topPadding),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20, width: double.infinity),
                FadeIn(
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 100),
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: WorkersSummary(),
                  ),
                ),
                SizedBox(height: 10, width: double.infinity),
                _PoolStatsButton(size: size),
                SizedBox(height: 40, width: double.infinity),
                FadeIn(
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 100),
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: Text('Miners', style: Theme.of(context).textTheme.headline2),
                  ),
                ),
                FadeIn(
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 100),
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: _MinerBoxList(),
                  ),
                ),
                SizedBox(height: 60, width: double.infinity),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MinerBoxList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MinersBloc, MinersState>(
      builder: (context, state) {
        if (state is MinersLoadedState) {
          return Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.miner.workers.length,
                itemBuilder: (BuildContext context, int index) => _MinerBoxItem(worker: state.miner.workers[index])),
          );
        }
        return Center(child: Text('No Miners'));
      },
    );
  }
}

class _MinerBoxItem extends StatelessWidget {
  final Workers worker;

  const _MinerBoxItem({
    Key key,
    this.worker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 150,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Opacity(
              opacity: 0.5,
              // child: EthExchangeRateChart(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20, top: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      worker.worker,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    SpinnerIndicator(
                      radius: 25,
                      showCenterData: false,
                      numerator: worker.currentHashrate > 0 ? 1 : 0,
                      denominator: 1,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      'Current hashrate:',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          worker.currentHashrate > 999
                              ? (worker.currentHashrate / 1000).toStringAsFixed(2)
                              : worker.currentHashrate.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          worker.currentHashrate > 999 ? ' GH/s' : ' MH/s',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Reported hashrate:',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          worker.reportedHashrate > 999
                              ? (worker.reportedHashrate / 1000).toStringAsFixed(2)
                              : worker.reportedHashrate.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          worker.reportedHashrate > 999 ? ' GH/s' : ' MH/s',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Average hashrate:',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          worker.averageHashrate > 999
                              ? (worker.averageHashrate / 1000).toStringAsFixed(2)
                              : worker.averageHashrate.toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          worker.averageHashrate > 999 ? ' GH/s' : ' MH/s',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PoolStatsButton extends StatelessWidget {
  const _PoolStatsButton({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: Duration(milliseconds: 100),
      duration: Duration(milliseconds: 300),
      child: SlideInUp(
        delay: Duration(milliseconds: 100),
        from: size.height - 100,
        duration: Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/pool-stats'),
          child: CustomContainer(
            padding: const EdgeInsets.all(0),
            height: 60,
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                'Pool statistics',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
