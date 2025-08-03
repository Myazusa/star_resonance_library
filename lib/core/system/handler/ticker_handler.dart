import 'dart:developer';

import 'package:star_resonance_toolkit/core/module/common/screen_capture_module.dart';
import 'package:star_resonance_toolkit/core/module/option_module.dart';
import 'package:star_resonance_toolkit/core/system/event/capture_event.dart';

import '../event/tick_event.dart';
import '../event_bus.dart';

class TickerHandler{
  static bool _isCaptureProcessing = false;

  static void handleCapture(TickEvent e) async{
    if(_isCaptureProcessing){
      return;
    }
    _isCaptureProcessing = true;
    try {
      final screenCaptureImage = await ScreenCaptureModule.capture(
        OptionModule.instance.gameScreenLeftTopPoint.x.toInt(),
        OptionModule.instance.gameScreenLeftTopPoint.y.toInt(),
        OptionModule.instance.gameScreenWidth,
        OptionModule.instance.gameScreenHeight
      );

      // todo: 记得给filename
      EventBus.instance.sendEvent(CaptureEvent(screenCaptureImage, ""));

    } catch (e, stack) {
      log("截图任务出错: $e\n$stack");
    } finally {
      _isCaptureProcessing = false;
    }
  }
}