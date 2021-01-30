part of 'wallet_bloc.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoadingState extends WalletState {}

class WalletLoadedState extends WalletState {
  final Wallet wallet;

  WalletLoadedState(this.wallet);
}
