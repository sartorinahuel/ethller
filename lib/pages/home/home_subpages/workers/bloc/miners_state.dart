part of 'miners_bloc.dart';

@immutable
abstract class MinersState {}

class MinersInitial extends MinersState {}

class MinersLoadingState extends MinersState {}

class MinersNoConnectionState extends MinersState {}

class MinersWalletNotFoundState extends MinersState {}

class MinersErrorState extends MinersState {
  final AppError appError;

  MinersErrorState(this.appError);
}

class MinersLoadedState extends MinersState {
  final Miner miner;

  MinersLoadedState(this.miner);
}
