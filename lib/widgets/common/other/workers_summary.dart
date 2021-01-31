import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller/widgets/common/other/custom_container.dart';
import 'package:ethller/widgets/common/other/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkersSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MinersBloc, MinersState>(
      builder: (BuildContext context, state) {
        if (state is MinersLoadedState) {

          return CustomContainer(
            height: 170,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 15),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/imgs/noun_miner_42900.png',
                        color: Colors.grey[600],
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Workers',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      SpinnerIndicator(
                        key: UniqueKey(),
                        denominator: state.miner.currentStats.activeWorkers,
                        numerator: state.miner.history.last.activeWorkers,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Current Hashrate',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        state.miner.currentStats.currentHashrate.toStringAsFixed(2),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        ' MH/s',
                        style: TextStyle(color: Colors.grey[300], fontSize: 11),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[600],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Reported Hashrate',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        state.miner.currentStats.reportedHashrate.toStringAsFixed(2),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        ' MH/s',
                        style: TextStyle(color: Colors.grey[300], fontSize: 11),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple[600],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Media Hashrate',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        state.miner.currentStats.averageHashrate.toStringAsFixed(2),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        ' MH/s',
                        style: TextStyle(color: Colors.grey[300], fontSize: 11),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue[600],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        if (state is MinersInitial) {
          return CustomContainer(
            height: 170,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 15),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/imgs/noun_miner_42900.png',
                        color: Colors.grey[600],
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Workers',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      SpinnerIndicator(
                        key: UniqueKey(),
                        denominator: 0,
                        numerator: 0,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Current Hashrate',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        '0',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        ' MH/s',
                        style: TextStyle(color: Colors.grey[300], fontSize: 11),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[600],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Reported Hashrate',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        '0',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        ' MH/s',
                        style: TextStyle(color: Colors.grey[300], fontSize: 11),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple[600],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Media Hashrate',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        '0',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        ' MH/s',
                        style: TextStyle(color: Colors.grey[300], fontSize: 11),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue[600],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return CustomContainer(child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
