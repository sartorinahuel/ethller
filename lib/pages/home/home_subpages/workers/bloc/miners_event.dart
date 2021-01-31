part of 'miners_bloc.dart';

@immutable
abstract class MinersEvent {}

class MinersInitEvent extends MinersEvent {
  final String walletId;

  MinersInitEvent(this.walletId);
}

class MinersRemoveMinersEvent extends MinersEvent {}

class MinersNoConnectionEvent extends MinersEvent {}

class MinersWalletNotFoundEvent extends MinersEvent {}

class MinersErrorEvent extends MinersEvent {
  final AppError appError;

  MinersErrorEvent(this.appError);
}

class MinersUpdateEvent extends MinersEvent {
  final Miner miner;

  MinersUpdateEvent(this.miner);
}
