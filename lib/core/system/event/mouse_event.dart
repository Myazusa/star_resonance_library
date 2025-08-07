import 'package:star_resonance_library/core/enum/mouse_action.dart';

class MouseEvent{
  int endX;
  int endY;

  MouseAction mouseAction;

  MouseEvent(this.endX, this.endY,this.mouseAction);
}