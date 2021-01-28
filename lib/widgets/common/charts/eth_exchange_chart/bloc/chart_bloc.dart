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

  @override
  Stream<ChartBlocState> mapEventToState(ChartBlocEvent event) async* {
    if (event is ChartInitEvent) {
      yield ChartLoadingState();
      await getCoinsUpdate();
      final List<double> list1 = [];
      oneDayPeriod.forEach((element) => list1.add(num.parse(element.price)));
      yield ChartDataState(list1);
    }

    if (event is ChartOneDayPeriodEvent) {
      yield ChartLoadingState();
      final List<double> list2 = [];
      oneDayPeriod.forEach((element) => list2.add(num.parse(element.price)));
      yield ChartDataState(list2);
    }

    if (event is ChartOneWeekPeriodEvent) {
      yield ChartLoadingState();
      final List<double> list3 = [];
      oneWeekPeriod.forEach((element) => list3.add(num.parse(element.price)));
      yield ChartDataState(list3);
    }

    if (event is ChartOneMonthPeriodEvent) {
      yield ChartLoadingState();
      final List<double> list4 = [];
      oneMonthPeriod.forEach((element) => list4.add(num.parse(element.price)));
      yield ChartDataState(list4);
    }

    if (event is ChartOneYearPeriodEvent) {
      yield ChartLoadingState();
      final List<double> list5 = [];
      oneYearPeriod.forEach((element) => list5.add(num.parse(element.price)));
      yield ChartDataState(list5);
    }

    if (event is ChartFiveYearsPeriodEvent) {
      yield ChartLoadingState();
      final List<double> list6 = [];
      fiveYearsPeriod.forEach((element) => list6.add(num.parse(element.price)));
      yield ChartDataState(list6);
    }
  }

  Future<void> getCoinsUpdate() async {
    oneDayPeriod.clear();
    oneDayPeriod = await coinHistoryRepo.getCoinHistoriesList(coinId, CoinHistoriesPeriod.ONEDAY);
    await Future.delayed(Duration(milliseconds: 200));
    oneWeekPeriod.clear();
    oneWeekPeriod = await coinHistoryRepo.getCoinHistoriesList(coinId, CoinHistoriesPeriod.ONEWEEK);
    await Future.delayed(Duration(milliseconds: 200));
    oneMonthPeriod.clear();
    oneMonthPeriod = await coinHistoryRepo.getCoinHistoriesList(coinId, CoinHistoriesPeriod.ONEMONTH);
    await Future.delayed(Duration(milliseconds: 200));
    oneYearPeriod.clear();
    oneYearPeriod = await coinHistoryRepo.getCoinHistoriesList(coinId, CoinHistoriesPeriod.ONEYEAR);
    await Future.delayed(Duration(milliseconds: 200));
    fiveYearsPeriod.clear();
    fiveYearsPeriod = await coinHistoryRepo.getCoinHistoriesList(coinId, CoinHistoriesPeriod.FIVEYEARS);
  }
}
