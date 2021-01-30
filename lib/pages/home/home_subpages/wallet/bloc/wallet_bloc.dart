import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    loadFromMemory();
  }

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    if (event is WalletInitEvent) {
      yield WalletLoadingState();
      updateTrigger = true;
      saveAddress(walletId);
      updateWalletData();
    }

    if (event is WalletUpdateEvent) {
      yield WalletLoadedState(event.wallet);
    }
  }

  void updateWalletData() async {
    do {
      final wallet = await walletRepo.getWalletData(walletId);
      add(WalletUpdateEvent(wallet));
      await Future.delayed(Duration(minutes: walletDataRefreshRate));
    } while (updateTrigger);
  }

  void loadFromMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedWallet = prefs.getString('address');
    print('on memory: $savedWallet');
    if (savedWallet != null) {
      walletId = savedWallet;
      add(WalletInitEvent());
    }
  }

  void saveAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);
  }
}
