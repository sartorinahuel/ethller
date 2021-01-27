import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:ethller/widgets/common/charts/eth_exchange_chart/eth_exchange_chart.dart';

class GeneralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 185 + topPadding, width: double.infinity),
            FadeIn(
              duration: Duration(milliseconds: 300),
              child: SlideInUp(
                from: size.height - 100,
                duration: Duration(milliseconds: 300),
                child: ExchangeChart('-l8Mn2pVlRs-p'),
              ),
            ),
          ],
        ),
      ),
    );
    // return SingleChildScrollView(
    //   physics: BouncingScrollPhysics(),
    //   child: Column(
    //     children: [
    //       SizedBox(height: 190),

    //       FadeIn(
    //         delay: Duration(milliseconds: 100),
    //         duration: Duration(milliseconds: 300),
    //         child: SlideInUp(
    //           delay: Duration(milliseconds: 100),
    //           from: size.height - 100,
    //           duration: Duration(milliseconds: 300),
    //           // child: WorkersSummary(),
    //         ),
    //       ),
    //       FadeIn(
    //         delay: Duration(milliseconds: 300),
    //         duration: Duration(milliseconds: 300),
    //         child: SlideInUp(
    //           delay: Duration(milliseconds: 300),
    //           from: size.height - 100,
    //           duration: Duration(milliseconds: 300),
    //           // child: PaymentsSummary(),
    //         ),
    //       ),
    //       FadeIn(
    //         delay: Duration(milliseconds: 500),
    //         duration: Duration(milliseconds: 300),
    //         child: SlideInUp(
    //           delay: Duration(milliseconds: 500),
    //           from: size.height - 100,
    //           duration: Duration(milliseconds: 300),
    //           // child: WalletSummary(),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
