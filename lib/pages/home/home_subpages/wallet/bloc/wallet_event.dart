part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class WalletInitEvent extends WalletEvent {
  final String walletId;

  WalletInitEvent(this.walletId);
}

class WalletRemoveWalletEvent extends WalletEvent {}

class WalletUpdateEvent extends WalletEvent {
  final Wallet wallet;

  WalletUpdateEvent(this.wallet);
}
