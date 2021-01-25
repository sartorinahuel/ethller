import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

class GeneralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(child: Text('general page')),
      ),
    );
    // return SingleChildScrollView(
    //   physics: BouncingScrollPhysics(),
    //   child: Column(
    //     children: [
    //       SizedBox(height: 190),
    //       FadeIn(
    //         duration: Duration(milliseconds: 300),
    //         child: SlideInUp(
    //           from: size.height - 100,
    //           duration: Duration(milliseconds: 300),
    //           // child: EthExchangeRate(),
    //         ),
    //       ),
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
