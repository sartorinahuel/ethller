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
      final PoolData poolData = await poolRepo.getPoolStats();
      updatePoolData();
      yield PoolLoadedState(poolData);
    }

    if (event is PoolUpdateEvent) {
      yield PoolLoadedState(event.poolData);
    }
  }

  void updatePoolData() async {
    final i = 0;
    do {
      await Future.delayed(Duration(minutes: poolDataRefreshRate));
      print('Getting pool data...');
      final PoolData poolData = await poolRepo.getPoolStats();
      add(PoolUpdateEvent(poolData));
      print('Pool data updated!!!');
    } while (i == 0);
  }
}
