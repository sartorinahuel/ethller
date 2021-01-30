import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:ethller/pages/settings/add_wallet/add_wallet_page.dart';
import 'package:ethller/pages/settings/settings_page.dart';
import 'package:ethller/pages/home/home_subpages/wallet/wallet_page.dart';
import 'package:ethller/pages/home/home_subpages/workers/miners_page.dart';
import 'package:ethller/pages/home/widgets/header/widgets/custom_drawer_button.dart';
import 'package:ethller/pages/home/home_subpages/general/general_page.dart';
import 'package:ethller/pages/home/provider/home_page_sub_pages_provider.dart';
import 'package:ethller/pages/home/widgets/header/widgets/selector_bar.dart';
import 'package:ethller/widgets/common/buttons/gradient_button.dart';

class HeaderHomePage extends StatefulWidget {
  @override
  _HeaderHomePageState createState() => _HeaderHomePageState();
}

class _HeaderHomePageState extends State<HeaderHomePage> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return AnimatedContainer(
      height: isOpen ? 300 + topPadding : 175 + topPadding,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Color(0xFF202143),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      duration: Duration(milliseconds: 200),
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 40, right: 10),
                  width: double.infinity,
                  child: Text(
                    'Stats',
                    style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: isOpen ? 155 : 30, //poner 40 aca
                ),
                SelectorBar(
                  items: [
                    SelectorBarButton(
                      title: 'General',
                      onPressed: () async {
                        Provider.of<HomePageSubPagesProvider>(context, listen: false).changePage = GeneralPage();
                      },
                    ),
                    SelectorBarButton(
                      title: 'Miners',
                      onPressed: () async {
                        Provider.of<HomePageSubPagesProvider>(context, listen: false).changePage = MinersPage();
                      },
                    ),
                    SelectorBarButton(
                      title: 'Wallets',
                      onPressed: () {
                        Provider.of<HomePageSubPagesProvider>(context, listen: false).changePage = WalletPage();
                      },
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 20,
              top: -2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomDrawerButton(
                    isOpen: isOpen,
                    onPressed: () {
                      setState(() {
                        isOpen = !isOpen;
                      });
                    },
                  ),
                  SizedBox(height: isOpen ? 10 : 0),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: isOpen ? 1.0 : 0.0,
                    child: isOpen
                        ? GradientButton(
                            height: 40,
                            isButton: true,
                            onPressed: () {
                              setState(() {
                                isOpen = !isOpen;
                              });
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddWalletPage()));
                            },
                            child: Text(
                              'Add Wallet',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : null,
                  ),
                  SizedBox(height: isOpen ? 20 : 0),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: isOpen ? 1.0 : 0.0,
                    child: isOpen
                        ? GradientButton(
                            isButton: true,
                            height: 40,
                            onPressed: () {
                              setState(() {
                                isOpen = !isOpen;
                              });
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
                            },
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
