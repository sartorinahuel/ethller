part of 'chart_bloc.dart';

@immutable
abstract class ChartBlocState {}

class ChartInitialState extends ChartBlocState {}

class ChartLoadingState extends ChartBlocState {}

class ChartDataState extends ChartBlocState {
  final List<double> chartValues;

  ChartDataState(this.chartValues);
}
