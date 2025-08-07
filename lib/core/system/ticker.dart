import 'dart:async';

import 'package:star_resonance_library/core/system/event/tick_event.dart';
import 'package:star_resonance_library/core/system/event_bus.dart';

class Ticker{
  Timer? _timer;
  Ticker._internal();
  static final Ticker _instance = Ticker._internal();
  static Ticker get instance {
    return _instance;
  }

  /// 开始后会持续发送帧调用的Event，如果需要每帧调用事件，就写一个handler然后订阅TickEvent
  void start({int intervalMs = 100}) {
    stop(); // 防止重复启动
    _timer = Timer.periodic(Duration(milliseconds: intervalMs), (_) {
      EventBus.instance.sendEvent(TickEvent(DateTime.now().microsecondsSinceEpoch));
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  bool get isRunning => _timer?.isActive ?? false;
}