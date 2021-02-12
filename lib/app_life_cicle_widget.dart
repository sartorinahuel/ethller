import 'package:ethller/pages/home/home_subpages/wallet/bloc/wallet_bloc.dart';
import 'package:ethller/widgets/common/charts/eth_exchange_chart/bloc/chart_bloc.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'pages/pool/bloc/pool_bloc.dart';

class LifeCicleWidget extends StatefulWidget {
  final Widget child;

  const LifeCicleWidget({Key key, this.child}) : super(key: key);

  @override
  _LifeCicleWidgetState createState() => _LifeCicleWidgetState();
}

class _LifeCicleWidgetState extends State<LifeCicleWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('state = $state');
    switch (state) {
      case AppLifecycleState.resumed:
        BlocProvider.of<ChartBloc>(context).add(ChartUpdateEvent());
        BlocProvider.of<PoolBloc>(context).add(PoolInitEvent());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final savedWallet = prefs.getString('address');
        print('on memory: $savedWallet');
        if (savedWallet != null) {
          try {
            final wallet = await walletRepo.getWalletData(savedWallet);
            BlocProvider.of<WalletBloc>(context).add(WalletUpdateEvent(wallet));
            final miner = await minersRepo.getMinerData(savedWallet);
            BlocProvider.of<MinersBloc>(context).add(MinersUpdateEvent(miner));
          } catch (e) {
            if (e == AppError.connectionTimeout() || e == AppError.noConnection()) {
              BlocProvider.of<WalletBloc>(context).add(WalletNoConnectionEvent());
              BlocProvider.of<MinersBloc>(context).add(MinersNoConnectionEvent());
            }
            if (e == AppError.maxRateLimitReached()) {
              print('Max limit reached!!!');
            }
            BlocProvider.of<WalletBloc>(context).add(WalletErrorEvent(e));
            BlocProvider.of<MinersBloc>(context).add(MinersErrorEvent(e));
          }
        }
        break;
      case AppLifecycleState.paused:
        updateTrigger = false;
        break;
      case AppLifecycleState.inactive:
        updateTrigger = false;
        break;
      case AppLifecycleState.detached:
        updateTrigger = false;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
