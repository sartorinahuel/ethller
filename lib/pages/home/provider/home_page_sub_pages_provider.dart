import 'package:flutter/material.dart';

import 'package:ethller/pages/home/home_subpages/general/general_page.dart';

class HomePageSubPagesProvider with ChangeNotifier {
  Widget _currentPage = GeneralPage();

  Widget get currentPage => this._currentPage;

  set changePage(Widget nextPage) {
    _currentPage = nextPage;
    notifyListeners();
  }
}