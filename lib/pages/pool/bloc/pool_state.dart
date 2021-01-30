part of 'pool_bloc.dart';

@immutable
abstract class PoolState {}

class PoolInitial extends PoolState {}

class PoolLoadingState extends PoolState {}

class PoolLoadedState extends PoolState {
  final PoolData poolData;

  PoolLoadedState(this.poolData);
}
