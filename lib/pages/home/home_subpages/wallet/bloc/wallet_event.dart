part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class WalletInitEvent extends WalletEvent {
  final String walletId;

  WalletInitEvent(this.walletId);
}

class WalletRemoveWalletEvent extends WalletEvent {}

class WalletNoConnectionEvent extends WalletEvent {}

class WalletErrorEvent extends WalletEvent {
  final AppError appError;

  WalletErrorEvent(this.appError);
}

class WalletUpdateEvent extends WalletEvent {
  final Wallet wallet;

  WalletUpdateEvent(this.wallet);
}
