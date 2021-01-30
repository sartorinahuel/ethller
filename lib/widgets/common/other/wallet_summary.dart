import 'package:ethller/pages/home/home_subpages/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_container.dart';

class WalletSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
        child: BlocBuilder<WalletBloc, WalletState>(
          builder: (BuildContext context, state) {
            if (state is WalletLoadedState) {
              final wallet = state.wallet;
              final balance = wallet.balance / 1000000000000000000;
              final inBTC = wallet.inBTC / 1000000000000000000;
              final inUSD = wallet.inUSD / 1000000000000000000;
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
                            balance.toStringAsFixed(5),
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
                            inBTC.toStringAsFixed(5),
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
                            inUSD.toStringAsFixed(2),
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
            }
            if (state is WalletInitial) {
              return Center(child: Text('No Wallet Added', style: Theme.of(context).textTheme.bodyText1));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
