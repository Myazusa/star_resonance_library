import 'package:star_resonance_toolkit/core/enum/mouse_action.dart';

class MouseEvent{
  int endX;
  int endY;

  MouseAction mouseAction;

  MouseEvent(this.endX, this.endY,this.mouseAction);
}