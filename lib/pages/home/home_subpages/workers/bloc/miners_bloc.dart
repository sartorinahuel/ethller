import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:meta/meta.dart';

part 'miners_event.dart';
part 'miners_state.dart';

class MinersBloc extends Bloc<MinersEvent, MinersState> {
  MinersBloc() : super(MinersInitial()) {
    if (walletId != 'walletId') {
      add(MinersInitEvent());
    }
  }

  @override
  Stream<MinersState> mapEventToState(MinersEvent event) async* {
    if (event is MinersInitEvent) {
      yield MinersLoadingState();
      // final miner = await minersRepo.getMinerData(walletId);
      updateMinerData();
    }

    if (event is MinersUpdateEvent) {
      yield MinersLoadedState(event.miner);
    }

    if (event is MinersRemoveMinersEvent) {
      yield MinersInitial();
    }
  }

  void updateMinerData() async {
    do {
      print('Getting miners data...');
      final miner = await minersRepo.getMinerData(walletId);
      add(MinersUpdateEvent(miner));
      print('Miners Data Updated!!!');
      await Future.delayed(Duration(minutes: minersDataRefreshRate));
    } while (updateTrigger);
  }
}
