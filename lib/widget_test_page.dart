import 'package:flutter/material.dart';

import 'widgets/common/charts/eth_exchange_chart/eth_exchange_chart.dart';

class WidgetTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: ExchangeChart('-l8Mn2pVlRs-p'),
        ),
      ),
    );
  }
}



///Stream de coinHistories
// return StreamBuilder<List<CoinHistory>>(
//         stream: coinHistoryRepo.coinHistoriesStream,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<CoinHistory> bitconHistory = [];
//             snapshot.data.forEach((ch) {
//               if (ch.coinId == 'Qwsogvtv82FCd') {
//                 bitconHistory.add(ch);
//               }
//             });
//             bitconHistory.sort((a, b) => a.date.compareTo(b.date));

//             return Scaffold(
//               appBar: AppBar(title: Text('Ethller')),
//               body: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                       'El precio del BITCOIN es \$${bitconHistory.last.price.toStringAsFixed(2)}'),
//                   SizedBox(height: 40, width: double.infinity),
//                   PlainButton(
//                     height: 44,
//                     width: 200,
//                     title: 'Pool Stats',
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (BuildContext context) => PoolStatsPage(),
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 40, width: double.infinity),
//                   SpinnerIndicator(denominator: 2, numerator: 2, radius: 100),
//                 ],
//               ),
//             );
//           }

//           return Scaffold(body: Center(child: Text('Loading...')));
//         });