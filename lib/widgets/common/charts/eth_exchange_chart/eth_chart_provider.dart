import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/material.dart';

enum Range { OneDay, OneWeek, OneMonth, OneYear, TwoYears }

class EthChartProvider with ChangeNotifier {
  String _rangeName = 'One Day';
  Stream<List<CoinHistory>> _oneDayRangeStream = coinHistoryRepo.oneDayRangeCoinHistoriesListStream;
  Stream<List<CoinHistory>> _oneWeekRangeStream = coinHistoryRepo.oneWeekRangeCoinHistoriesListStream;
  Stream<List<CoinHistory>> _oneMonthRangeStream = coinHistoryRepo.oneMonthRangeCoinHistoriesListStream;
  Stream<List<CoinHistory>> _oneYearRangeStream = coinHistoryRepo.oneYearRangeCoinHistoriesListStream;
  Stream<List<CoinHistory>> _twoYearsRangeStream = coinHistoryRepo.twoYearsRangeCoinHistoriesListStream;

  Stream<List<CoinHistory>> _selectedRangeStream = coinHistoryRepo.oneDayRangeCoinHistoriesListStream;

  double _change = 0;

  Stream<List<CoinHistory>> get rangeStream => this._selectedRangeStream;
  double get change => this._change;
  String get rangeName => this._rangeName;

  set selectRange(Range range) {
    switch (range) {
      case Range.OneDay:
        _selectedRangeStream = _oneDayRangeStream;
        _rangeName = 'One Day';
        notifyListeners();
        break;
      case Range.OneWeek:
        _selectedRangeStream = _oneWeekRangeStream;
        _rangeName = 'One Week';
        notifyListeners();
        break;
      case Range.OneMonth:
        _selectedRangeStream = _oneMonthRangeStream;
        _rangeName = 'One Month';
        notifyListeners();
        break;
      case Range.OneYear:
        _selectedRangeStream = _oneYearRangeStream;
        _rangeName = 'One Year';
        notifyListeners();
        break;
      case Range.TwoYears:
        _selectedRangeStream = _twoYearsRangeStream;
        _rangeName = 'Two Year';
        notifyListeners();
        break;
      default:
        _selectedRangeStream = _oneDayRangeStream;
        notifyListeners();
    }
  }

  set setChange(double c) {
    _change = c;
  }
}
