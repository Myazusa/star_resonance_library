import 'package:star_resonance_library/core/enum/mouse_action.dart';
import 'package:star_resonance_library/core/module/common/simulation_module.dart';
import 'package:star_resonance_library/core/system/event/mouse_event.dart';

class SimulationHandler{
  static Future<void> handleMouseMove(MouseEvent e) async {
    if(e.mouseAction != MouseAction.none){
      return;
    }

    SimulationModule.moveMouseTo(e.endX, e.endY);
  }
  static Future<void> handleMouseMoveAndLeftClick(MouseEvent e) async{
    if(e.mouseAction != MouseAction.leftClick){
      return;
    }

    SimulationModule.moveMouseTo(e.endX, e.endY);
    SimulationModule.setDelayTime(delayMs: 120);
    SimulationModule.pressMouseLeft();
    SimulationModule.setDelayTime();
    SimulationModule.releaseMouseLeft();
  }
}