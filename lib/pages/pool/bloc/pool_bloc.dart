import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ethller_api_interface/ethller_api_interface.dart';
import 'package:meta/meta.dart';

part 'pool_event.dart';
part 'pool_state.dart';

class PoolBloc extends Bloc<PoolEvent, PoolState> {
  PoolBloc() : super(PoolInitial());

  @override
  Stream<PoolState> mapEventToState(PoolEvent event) async* {
    if (event is PoolInitEvent) {
      yield PoolLoadingState();
      updatePoolData();
    }

    if (event is PoolUpdateEvent) {
      yield PoolLoadedState(event.poolData);
    }

    if (event is PoolNoConnectionEvent) {
      yield PoolNoConnectionState();
    }
    
    if (event is PoolErrorEvent) {
      yield PoolErrorState(event.appError);
    }
  }

  void updatePoolData() async {
    final i = 0;
    do {
      try {
        print('Getting pool data...');
        final PoolData poolData = await poolRepo.getPoolStats();
        add(PoolUpdateEvent(poolData));
        print('Pool data updated!!!');
      } catch (e) {
        if(e == AppError.connectionTimeout() || e == AppError.noConnection()){
          add(PoolNoConnectionEvent());
        }
        add(PoolErrorEvent(e));
      }
      await Future.delayed(Duration(minutes: poolDataRefreshRate));
    } while (i == 0);
  }
}
