part of 'chart_bloc.dart';

@immutable
abstract class ChartBlocEvent {}

class ChartInitEvent extends ChartBlocEvent {}

class ChartUpdateEvent extends ChartBlocEvent {}

class ChartOneDayPeriodEvent extends ChartBlocEvent {}

class ChartOneWeekPeriodEvent extends ChartBlocEvent {}

class ChartOneMonthPeriodEvent extends ChartBlocEvent {}

class ChartOneYearPeriodEvent extends ChartBlocEvent {}

class ChartFiveYearsPeriodEvent extends ChartBlocEvent {}

class ChartNoConnectionEvent extends ChartBlocEvent {}

class ChartErrorEvent extends ChartBlocEvent {
  final AppError appError;

  ChartErrorEvent(this.appError);
}
