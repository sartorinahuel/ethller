import 'package:animate_do/animate_do.dart';
import 'package:ethller/widgets/common/other/custom_container.dart';
import 'package:ethller/widgets/common/other/workers_summary.dart';
import 'package:flutter/material.dart';

class WorkersPage extends StatelessWidget {
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
                delay: Duration(milliseconds: 100),
                from: size.height - 100,
                duration: Duration(milliseconds: 300),
                child: WorkersSummary(),
              ),
            ),
            SizedBox(height: 10),
            FadeIn(
              delay: Duration(milliseconds: 100),
              duration: Duration(milliseconds: 300),
              child: SlideInUp(
                delay: Duration(milliseconds: 100),
                from: size.height - 100,
                duration: Duration(milliseconds: 300),
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
            //TODO add workers detail
          ],
        ),
      ),
    );
  }
}
