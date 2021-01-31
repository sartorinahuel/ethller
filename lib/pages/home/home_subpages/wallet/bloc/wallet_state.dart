part of 'wallet_bloc.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoadingState extends WalletState {}

class WalletNoConnectionState extends WalletState {}

class WalletErrorState extends WalletState {
  final AppError appError;

  WalletErrorState(this.appError);
}

class WalletLoadedState extends WalletState {
  final Wallet wallet;

  WalletLoadedState(this.wallet);
}
