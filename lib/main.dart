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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ethller',
      theme: ThemeService.darkTheme,
      home: BlocProvider(
        create: (context) => ChartBloc('razxDUgYGNAdQ')..add(ChartInitEvent()),
        child: HomePage(),
      ),
      // home: WidgetTestPage(),
    );
  }
}
