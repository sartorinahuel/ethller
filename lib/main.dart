import 'package:ethller/theme/theme_service.dart';
import 'package:flutter/material.dart';

import 'package:ethller_api_interface/ethller_api_interface.dart';

import 'package:ethller/pages/home/home_page.dart';
import 'package:ethller/widget_test_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    coinHistoryRepo.getCoinHistoriesList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ethller',
      theme: ThemeService.darkTheme,
      home: HomePage(),
      // home: WidgetTestPage(),
    );
  }
}
