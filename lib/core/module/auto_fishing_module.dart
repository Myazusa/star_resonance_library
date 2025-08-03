
import 'package:star_resonance_toolkit/core/module/common/screen_capture_module.dart';
import 'package:star_resonance_toolkit/core/module/option_module.dart';


class AutoFishingModule {
  static AutoFishingModule? _instance;

  bool isFishing = false;
  bool isTakeHook = false;
  bool isEnable = false;

  double stepWaitTime = 2.0;

  factory AutoFishingModule({bool isEnable = false}) {
    return _instance ??= AutoFishingModule._internal(false);
  }

  static AutoFishingModule get instance {
    return _instance ??= AutoFishingModule._internal(false);
  }

  AutoFishingModule._internal(this.isEnable);

  void startFishing() async {
    if(isEnable){
      ScreenCaptureModule.capture(0,0,OptionModule.instance.gameScreenWidth,OptionModule.instance.gameScreenHeight);
    }
  }
}