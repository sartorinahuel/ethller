part of 'pool_bloc.dart';

@immutable
abstract class PoolState {}

class PoolInitial extends PoolState {}

class PoolLoadingState extends PoolState {}

class PoolNoConnectionState extends PoolState {}

class PoolErrorState extends PoolState {
  final AppError appError;

  PoolErrorState(this.appError);
}


class PoolLoadedState extends PoolState {
  final PoolData poolData;

  PoolLoadedState(this.poolData);
}
