import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:meta/meta.dart';

part 'miners_event.dart';
part 'miners_state.dart';

class MinersBloc extends Bloc<MinersEvent, MinersState> {
  MinersBloc() : super(MinersInitial());

  @override
  Stream<MinersState> mapEventToState(MinersEvent event) async* {
    if (event is MinersInitEvent) {
      yield MinersLoadingState();
      updateMinerData(event.walletId);
    }

    if (event is MinersUpdateEvent) {
      yield MinersLoadedState(event.miner);
    }

    if (event is MinersRemoveMinersEvent) {
      updateTrigger = false;
      yield MinersInitial();
    }

    if (event is MinersErrorEvent) {
      yield MinersErrorState(event.appError);
    }

    if (event is MinersWalletNotFoundEvent) {
      yield MinersWalletNotFoundState();
    }
  }

  void updateMinerData(String walletId) async {
    do {
      try {
        print(DateTime.now().toString() + ': Getting miners data...');
        final miner = await minersRepo.getMinerData(walletId);
        add(MinersUpdateEvent(miner));
        print(DateTime.now().toString() + ': Miners Data Updated!!!');
      } catch (e) {
        add(MinersErrorEvent(e));
      }
      await Future.delayed(Duration(minutes: minersDataRefreshRate));
    } while (updateTrigger);
  }
}
