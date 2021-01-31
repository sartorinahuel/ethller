import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:meta/meta.dart';

part 'chart_bloc_event.dart';
part 'chart_bloc_state.dart';

class ChartBloc extends Bloc<ChartBlocEvent, ChartBlocState> {
  final String coinId;

  ChartBloc(this.coinId) : super(ChartInitialState());

  List<History> oneDayPeriod = [];
  List<History> oneWeekPeriod = [];
  List<History> oneMonthPeriod = [];
  List<History> oneYearPeriod = [];
  List<History> fiveYearsPeriod = [];

  CoinHistoriesPeriod _selectedPeriod = CoinHistoriesPeriod.ONEDAY;

  @override
  Stream<ChartBlocState> mapEventToState(ChartBlocEvent event) async* {
    if (event is ChartInitEvent) {
      yield ChartLoadingState();
      await getCoinsHistories();
      final List<double> list1 = [];
      oneDayPeriod.forEach((element) {
        final number = num.parse(element.price).toDouble().toStringAsFixed(2);
        return list1.add(num.parse(number).toDouble());
      });
      yield ChartDataState(list1);
      updateCoinHistories();
    }

    if (event is ChartOneDayPeriodEvent) {
      yield ChartLoadingState();
      final List<double> list2 = [];
      oneDayPeriod.forEach((element) {
        final number = num.parse(element.price).toDouble().toStringAsFixed(2);
        return list2.add(num.parse(number).toDouble());
      });
      _selectedPeriod = CoinHistoriesPeriod.ONEDAY;
      yield ChartDataState(list2);
    }

    if (event is ChartOneWeekPeriodEvent) {
      yield ChartLoadingState();
      final List<double> list3 = [];
      oneWeekPeriod.forEach((element) {
        final number = num.parse(element.price).toDouble().toStringAsFixed(2);
        return list3.add(num.parse(number).toDouble());
      });
      _selectedPeriod = CoinHistoriesPeriod.ONEWEEK;
      yield ChartDataState(list3);
    }

    if (event is ChartOneMonthPeriodEvent) {
      yield ChartLoadingState();
      final List<double> list4 = [];
      oneMonthPeriod.forEach((element) {
        final number = num.parse(element.price).toDouble().toStringAsFixed(2);
        return list4.add(num.parse(number).toDouble());
      });
      _selectedPeriod = CoinHistoriesPeriod.ONEMONTH;
      yield ChartDataState(list4);
    }

    if (event is ChartOneYearPeriodEvent) {
      yield ChartLoadingState();
      final List<double> list5 = [];
      oneYearPeriod.forEach((element) {
        final number = num.parse(element.price).toDouble().toStringAsFixed(2);
        return list5.add(num.parse(number).toDouble());
      });
      _selectedPeriod = CoinHistoriesPeriod.ONEYEAR;
      yield ChartDataState(list5);
    }

    if (event is ChartFiveYearsPeriodEvent) {
      yield ChartLoadingState();
      final List<double> list6 = [];
      fiveYearsPeriod.forEach((element) {
        final number = num.parse(element.price).toDouble().toStringAsFixed(2);
        return list6.add(num.parse(number).toDouble());
      });
      _selectedPeriod = CoinHistoriesPeriod.FIVEYEARS;
      yield ChartDataState(list6);
    }

    if (event is ChartNoConnectionEvent) {
      yield ChartNoConnectionState();
    }

    if (event is ChartErrorEvent) {
      yield ChartErrorState(event.appError);
    }
  }

  Future<void> getCoinsHistories() async {
    try {
      oneDayPeriod.clear();
      oneDayPeriod = await coinHistoryRepo.getCoinHistoriesList(
          coinId, CoinHistoriesPeriod.ONEDAY);
      await Future.delayed(Duration(milliseconds: 200));
      oneWeekPeriod.clear();
      oneWeekPeriod = await coinHistoryRepo.getCoinHistoriesList(
          coinId, CoinHistoriesPeriod.ONEWEEK);
      await Future.delayed(Duration(milliseconds: 200));
      oneMonthPeriod.clear();
      oneMonthPeriod = await coinHistoryRepo.getCoinHistoriesList(
          coinId, CoinHistoriesPeriod.ONEMONTH);
      await Future.delayed(Duration(milliseconds: 200));
      oneYearPeriod.clear();
      oneYearPeriod = await coinHistoryRepo.getCoinHistoriesList(
          coinId, CoinHistoriesPeriod.ONEYEAR);
      await Future.delayed(Duration(milliseconds: 200));
      fiveYearsPeriod.clear();
      fiveYearsPeriod = await coinHistoryRepo.getCoinHistoriesList(
          coinId, CoinHistoriesPeriod.FIVEYEARS);
    } catch (e) {
      if (e == AppError.connectionTimeout() || e == AppError.noConnection()) {
        add(ChartNoConnectionEvent());
      }
      add(ChartErrorEvent(e));
    }
  }

  void updateCoinHistories() async {
    final i = 0;
    do {
      await Future.delayed(Duration(minutes: coinsHistoriesRefreshRate));
      print('Getting coins histories...');
      await getCoinsHistories();
      print('Coins histories updates!!!');
      switch (_selectedPeriod) {
        case CoinHistoriesPeriod.ONEDAY:
          add(ChartOneDayPeriodEvent());
          break;
        case CoinHistoriesPeriod.ONEWEEK:
          add(ChartOneWeekPeriodEvent());
          break;
        case CoinHistoriesPeriod.ONEMONTH:
          add(ChartOneMonthPeriodEvent());
          break;
        case CoinHistoriesPeriod.ONEYEAR:
          add(ChartOneYearPeriodEvent());
          break;
        case CoinHistoriesPeriod.FIVEYEARS:
          add(ChartFiveYearsPeriodEvent());
          break;
        default:
          add(ChartOneDayPeriodEvent());
      }
    } while (i == 0);
  }
}
