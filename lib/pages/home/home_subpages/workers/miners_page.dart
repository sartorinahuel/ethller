import 'package:animate_do/animate_do.dart';
import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller/widgets/common/other/custom_container.dart';
import 'package:ethller/widgets/common/other/workers_summary.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MinersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: 165 + topPadding),
        child: RefreshIndicator(
          onRefresh: () async {
            if (walletUID != '') {
              BlocProvider.of<MinersBloc>(context)
                  .add(MinersInitEvent(walletUID));
            }
            await Future.delayed(Duration(seconds: 1));
            print('Done Update');
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 20, width: double.infinity),
                FadeIn(
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 100),
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: WorkersSummary(),
                  ),
                ),
                SizedBox(height: 10),
                //TODO sacar desde aca hasta...
                FadeIn(
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 100),
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: WorkersSummary(),
                  ),
                ),
                SizedBox(height: 10),
                FadeIn(
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 100),
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: WorkersSummary(),
                  ),
                ),
                SizedBox(height: 10),
                 //TODO ...hasta acá.
                FadeIn(
                  delay: Duration(milliseconds: 100),
                  duration: Duration(milliseconds: 300),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 100),
                    from: size.height - 100,
                    duration: Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/pool-stats'),
                      child: CustomContainer(
                        padding: const EdgeInsets.all(0),
                        height: 60,
                        width: size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            'Pool statistics',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //TODO add workers detail
              ],
            ),
          ),
        ),
      ),
    );
  }
}
