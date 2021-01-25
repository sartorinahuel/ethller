import 'package:ethller/pages/home/provider/home_page_sub_pages_provider.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:ethller/pages/home/widgets/header/header.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageSubPagesProvider(),
      child: Builder(builder: (BuildContext context) {
        final currentPage = Provider.of<HomePageSubPagesProvider>(context).currentPage;
        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                currentPage,
                FadeIn(
                  duration: Duration(milliseconds: 800),
                  child: SlideInDown(
                    duration: Duration(milliseconds: 900),
                    child: HeaderHomePage(),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
