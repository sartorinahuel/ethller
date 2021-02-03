import 'package:ethller/pages/home/home_subpages/wallet/bloc/wallet_bloc.dart';
import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller/widgets/common/charts/eth_exchange_chart/bloc/chart_bloc.dart';
import 'package:ethller/widgets/common/other/payments_summary.dart';
import 'package:ethller/widgets/common/other/wallet_summary.dart';
import 'package:ethller/widgets/common/other/workers/workers_summary.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:ethller/widgets/common/charts/eth_exchange_chart/eth_exchange_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: 165 + topPadding),
        child: RefreshIndicator(
          displacement: 30,
          onRefresh: () async {
            // coinRepo.getCoins();
            BlocProvider.of<ChartBloc>(context).add(ChartInitEvent());
            if (walletUID != '') {
              BlocProvider.of<WalletBloc>(context).add(WalletInitEvent(walletUID));
              BlocProvider.of<MinersBloc>(context).add(MinersInitEvent(walletUID));
            }
            print('Done refresh');
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20, width: double.infinity),
                FadeIn(
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: ExchangeChart(key: UniqueKey(), coinId: 'razxDUgYGNAdQ'),
                  ),
                ),
                FadeIn(
                  delay: Duration(milliseconds: 100),
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 100),
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: WorkersSummary(),
                  ),
                ),
                FadeIn(
                  delay: Duration(milliseconds: 300),
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 300),
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: PaymentsSummary(),
                  ),
                ),
                FadeIn(
                  delay: Duration(milliseconds: 500),
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 500),
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: WalletSummary(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
