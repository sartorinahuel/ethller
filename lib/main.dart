import 'package:ethller/pages/add_wallet/add_wallet_page.dart';
import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller/pages/pool/bloc/pool_bloc.dart';
import 'package:ethller/pages/pool/pool_detail_page.dart';
import 'package:ethller/pages/settings/settings_page.dart';
import 'package:ethller/theme/theme_service.dart';
import 'package:ethller/widgets/common/charts/eth_exchange_chart/bloc/chart_bloc.dart';
import 'package:flutter/material.dart';

import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethller/pages/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    coinRepo.getCoins();
    //Esto es temporal hasta que este el add wallet
    walletId = '0xF02bB51E0aEbCE3FeDd890555A19582FEBa1Eb3a';
    minersRepo.getMinerData(walletId);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChartBloc('razxDUgYGNAdQ')..add(ChartInitEvent())),
        BlocProvider(create: (context) => PoolBloc()..add(PoolInitEvent())),
        BlocProvider(create: (context) => MinersBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ethller',
        theme: ThemeService.darkTheme,
        home: HomePage(),
        routes: {
          '/pool-stats': (context) => PoolStatsPage(),
          '/settings': (context) => SettingsPage(),
          '/add-wallet': (context) => AddWalletPage(),
        },
      ),
    );
  }
}
