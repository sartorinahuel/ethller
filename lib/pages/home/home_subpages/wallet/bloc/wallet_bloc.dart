import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:meta/meta.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    if (walletId != 'walletId') {
      add(WalletInitEvent());
    }
  }

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    if (event is WalletInitEvent) {
      yield WalletLoadingState();
      final wallet = await walletRepo.getWalletData(walletId);
      updateWalletData();
      yield WalletLoadedState(wallet);
    }

    if (event is WalletUpdateEvent) {
      yield WalletLoadedState(event.wallet);
    }
  }

  void updateWalletData() async {
    final i = 0;
    do {
      await Future.delayed(Duration(minutes: walletDataRefreshRate));
      final wallet = await walletRepo.getWalletData(walletId);
      add(WalletUpdateEvent(wallet));
    } while (i == 0);
  }
}
