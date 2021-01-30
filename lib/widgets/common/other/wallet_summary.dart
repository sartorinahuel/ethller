import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
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
        child: BlocBuilder<MinersBloc, MinersState>(
          builder: (BuildContext context, state) {
            if (state is MinersLoadedState) {
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
                            '0',
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
                            '0',
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
                            '0',
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
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
