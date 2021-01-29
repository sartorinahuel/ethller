import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/material.dart';

class ChartHeader extends StatelessWidget {
  final String coinId;
  final double activeChange;
  final num price;

  const ChartHeader({Key key, this.coinId, this.activeChange, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Coin coin = coinRepo.coins.firstWhere((element) => element.uuid == coinId);
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 15),
      child: Row(
        children: [
          //TODO network image
          Image.asset(
            'assets/imgs/ethereum.png',
            height: 30,
            width: 30,
          ),
          SizedBox(width: 10),
          Text(
            '${coin.symbol} - USD',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    '\$ ${price.toStringAsFixed(2)}.-',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    ' USD',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: activeChange > 0 ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      activeChange > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                      color: Colors.white,
                      size: 12,
                    ),
                    Text(
                      '${activeChange.toStringAsFixed(2)} %',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
