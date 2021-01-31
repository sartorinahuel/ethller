part of 'pool_bloc.dart';

@immutable
abstract class PoolEvent {}

class PoolInitEvent extends PoolEvent {}

class PoolNoConnectionEvent extends PoolEvent {}

class PoolErrorEvent extends PoolEvent {
  final AppError appError;

  PoolErrorEvent(this.appError);
}

class PoolUpdateEvent extends PoolEvent {
  final PoolData poolData;

  PoolUpdateEvent(this.poolData);
}
