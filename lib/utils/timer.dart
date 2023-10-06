import 'dart:async';

import '../providers/Truck _provider/fair_provider.dart';

class TimerSingleton {
  static TimerSingleton? _instance;
  Timer? _timer;

  // factory TimerSingleton() {
  //   if (_instance == null) {
  //     _instance = TimerSingleton._internal();
  //   }
  //   return _instance!;
  // }

  static TimerSingleton get instance {
    if (_instance == null) {
      _instance = TimerSingleton._internal();
    }
    return _instance!;
  }

  TimerSingleton._internal();

  Timer? get timer => _timer;

  void startTimer(String orderId) {
    stopTimer();
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) {
        fairTruckProvider.updateSingleOrder(orderId);
      });
    }
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }
}