part of 'miners_bloc.dart';

@immutable
abstract class MinersEvent {}

class MinersInitEvent extends MinersEvent {
  final String walletId;

  MinersInitEvent(this.walletId);
}

class MinersRemoveMinersEvent extends MinersEvent {}

class MinersUpdateEvent extends MinersEvent {
  final Miner miner;

  MinersUpdateEvent(this.miner);
}
