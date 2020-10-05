import 'dart:async';
import 'package:logger/logger.dart';
import 'package:food_app/shared/config.dart';

abstract class ServiceCommon {
  String name;
  String description;
  String serviceVersion;
  bool active = false;
  bool cycleComplete = true;
  bool frcCycle;
  int duration = Config.serviceCycleDelay;
  Logger log = Config.log;

  Future<bool> perform();

  void setStatus(bool set) => active = set;

  bool status() => active;

  void start() => active = true;

  void stop() => active = false;
  
  initiate() => _cycle();

  forceCycle() => frcCycle = true;

  pauseDuration({int seconds = Config.serviceCycleDelay}) {
    this.duration = seconds;
  }

  _cycle() async =>
      Timer.periodic(Duration(seconds: duration), (Timer t) => _operation());

  _operation() async {
    if (frcCycle) cycleComplete = true;
    if (active && cycleComplete) {
      cycleComplete = await perform();
    }
  }
}
