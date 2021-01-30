part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class WalletInitEvent extends WalletEvent {}

class WalletUpdateEvent extends WalletEvent {
  final Wallet wallet;

  WalletUpdateEvent(this.wallet);
}
