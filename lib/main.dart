import 'package:flutter/material.dart';

import 'package:ethller_api_interface/ethller_api_interface.dart';

import 'package:ethller/pages/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    coinHistoryRepo.getCoinHistoriesList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ethller',
      home: HomePage(),
    );
  }
}
