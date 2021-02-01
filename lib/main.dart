import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethller/theme/theme_service.dart';
import 'package:ethller/pages/home/home_page.dart';
import 'package:ethller/pages/home/home_subpages/wallet/bloc/wallet_bloc.dart';
import 'package:ethller/pages/settings/add_wallet/add_wallet_page.dart';
import 'package:ethller/pages/settings/donations/donations_page.dart';
import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller/pages/pool/bloc/pool_bloc.dart';
import 'package:ethller/pages/pool/pool_detail_page.dart';
import 'package:ethller/pages/settings/settings_page.dart';
import 'package:ethller/widgets/common/charts/eth_exchange_chart/bloc/chart_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ChartBloc('razxDUgYGNAdQ')..add(ChartInitEvent())),
        BlocProvider(create: (_) => PoolBloc()..add(PoolInitEvent())),
        BlocProvider(create: (_) => MinersBloc()),
        BlocProvider(create: (context) => WalletBloc(context)),
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
          '/donations': (context) => DonationsPage(),
        },
      ),
    );
  }
}
