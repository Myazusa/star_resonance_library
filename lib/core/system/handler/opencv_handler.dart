import 'package:star_resonance_toolkit/core/enum/mouse_action.dart';
import 'package:star_resonance_toolkit/core/module/common/opencv_module.dart';
import 'package:star_resonance_toolkit/core/module/option_module.dart';
import 'package:star_resonance_toolkit/core/system/event/capture_event.dart';
import 'package:star_resonance_toolkit/core/system/event/mouse_event.dart';
import 'package:star_resonance_toolkit/core/system/event_bus.dart';

class OpencvHandler{
  static Future<void> handleOpencvProcessScreenCaptureImage(CaptureEvent e) async{
    final centerPoint = await OpencvModule.processScreenCaptureImage(e.screenCaptureImage, e.fileName);
    if(centerPoint == null){
      return;
    }

    int endX = centerPoint.$1 + OptionModule.instance.gameScreenLeftTopPoint.x.toInt();
    int endY = centerPoint.$2 + OptionModule.instance.gameScreenLeftTopPoint.y.toInt();

    EventBus.instance.sendEvent(MouseEvent(endX,endY,MouseAction.leftClick));
  }
}