import 'package:flutter/material.dart';

import 'custom_container.dart';

class WalletSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        child: 0.1 == null
            // child: wallet.wallet == null
            ? Center(
                child: Text(
                  'No Wallet added',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              )
            : 0.1 == 0.0
                // : wallet.balance == 0.0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Builder(
                    builder: (BuildContext context) {
                      final double walletBalanceBTC = 0.01242;
                      // wallet.balance * EtherscanAPI.exchangeRates['ethbtc'];
                      final double walletBalanceUSD = 354.23;
                      // wallet.balance * EtherscanAPI.exchangeRates['ethusd'];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.account_balance_wallet,
                                color: Colors.grey[600],
                                size: 30,
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Wallet Balance',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '0.2045',
                                    // 'wallet.balance.toStringAsFixed(6)',
                                    style: TextStyle(color: Colors.white, fontSize: 22),
                                  ),
                                  Text(
                                    ' ETH',
                                    style: TextStyle(color: Colors.white, fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    walletBalanceBTC.toStringAsFixed(6),
                                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                                  ),
                                  Text(
                                    ' BTC',
                                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    walletBalanceUSD.toStringAsFixed(2),
                                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                                  ),
                                  Text(
                                    ' USD',
                                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
      ),
    );
  }
}
