part of 'miners_bloc.dart';

@immutable
abstract class MinersState {}

class MinersInitial extends MinersState {}

class MinersLoadingState extends MinersState {}

class MinersLoadedState extends MinersState {
  final Miner miner;

  MinersLoadedState(this.miner);
}
