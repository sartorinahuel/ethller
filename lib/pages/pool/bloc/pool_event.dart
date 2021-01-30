part of 'pool_bloc.dart';

@immutable
abstract class PoolEvent {}

class PoolInitEvent extends PoolEvent {}

class PoolUpdateEvent extends PoolEvent {
  final PoolData poolData;

  PoolUpdateEvent(this.poolData);
}
