import 'package:star_resonance_library/core/module/common/item_data_module.dart';
import 'package:star_resonance_library/core/module/common/opencv_module.dart';
import 'package:star_resonance_library/core/system/event_bus.dart';
import 'package:star_resonance_library/core/system/handler/opencv_handler.dart';
import 'package:star_resonance_library/core/system/handler/simulation_handler.dart';
import 'package:star_resonance_library/core/system/ticker.dart';

class Init{
  static void initTicker(){
    Ticker.instance.start(intervalMs: 500);
  }
  static void initEventBus(){
    EventBus.instance.cancelAll();

    // 这是个示例，并不代表只能在这里订阅，可以在任何地方被订阅及取消
    // EventBus.instance.subscribeEvent("Capture", TickerHandler.handleCapture);
    EventBus.instance.subscribeEvent("Opencv", OpencvHandler.handleOpencvProcessScreenCaptureImage);
    EventBus.instance.subscribeEvent("Simulation", SimulationHandler.handleMouseMove);
  }
  static void initGreyQueryMatMap(){
    OpencvModule.initGreyQueryMatMap();
  }
  static Future<void> initItemData() async {
    await ItemDataModule.instance.initItemData();
  }
}

class Dest{
  static void destTicker(){
    Ticker.instance.stop();
  }

  static void destEventBus(){
    EventBus.instance.cancelAll();
  }

  static void destGreyQueryMatMap(){
    OpencvModule.destGreyQueryMatMap();
  }
  static void destItemData(){
    ItemDataModule.instance.destItemData();
  }
}