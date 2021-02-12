import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ethller/pages/home/home_subpages/workers/bloc/miners_bloc.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  BuildContext context;

  WalletBloc(this.context) : super(WalletInitial()) {
    loadFromMemory(context);
  }

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    if (event is WalletInitEvent) {
      yield WalletLoadingState();
      updateTrigger = true;
      saveAddress(event.walletId);
      updateWalletData(event.walletId);
    }

    if (event is WalletUpdateEvent) {
      yield WalletLoadedState(event.wallet);
    }

    if (event is WalletNoConnectionEvent) {
      yield WalletNoConnectionState();
    }

    if (event is WalletErrorEvent) {
      yield WalletErrorState(event.appError);
    }

    if (event is WalletRemoveWalletEvent) {
      removeWallet();
      walletUID = '';
      updateTrigger = false;
      yield WalletInitial();
    }
  }

  void updateWalletData(String walletId) async {
    do {
      try {
        final wallet = await walletRepo.getWalletData(walletId);
        add(WalletUpdateEvent(wallet));
      } catch (e) {
        if (e == AppError.connectionTimeout() || e == AppError.noConnection()) {
          add(WalletNoConnectionEvent());
        }
        if (e == AppError.maxRateLimitReached()) {
          print(DateTime.now().toString() + ': Max limit reached!!!');
        }
        add(WalletErrorEvent(e));
      }
      await Future.delayed(Duration(minutes: walletDataRefreshRate));
    } while (updateTrigger);
  }

  void loadFromMemory(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedWallet = prefs.getString('address');
    print('on memory: $savedWallet');
    if (savedWallet != null) {
      add(WalletInitEvent(savedWallet));
      BlocProvider.of<MinersBloc>(context).add(MinersInitEvent(savedWallet));
    }
  }

  void saveAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);
  }

  void removeWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', null);
    updateTrigger = false;
    BlocProvider.of<MinersBloc>(context).add(MinersRemoveMinersEvent());
  }
}
