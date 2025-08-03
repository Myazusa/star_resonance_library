import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_resonance_toolkit/core/util/win32_util.dart';
import 'package:star_resonance_toolkit/ui/state/game_screen_state.dart';



/// 懒加载单例
class OptionModule {
  static OptionModule? _instance;

  int gameScreenWidth;
  int gameScreenHeight;

  Point  gameScreenLeftTopPoint;

  /// 执行成功后会设置宽和高
  /// 返回操作结果，0为成功，1为失败
  int getGameScreenInfo(WidgetRef ref){
    final gameTile = "星痕共鸣";

    final windowInfo = Win32Util.getClientAreaRectByTitle(gameTile);
    if (windowInfo == null){
      return 1;
    }

    final windowPoint = Win32Util.getClientAreaTopLeft(gameTile);
    if(windowPoint == null){
      return 1;
    }

    gameScreenHeight = windowInfo.bottom - windowInfo.top;
    gameScreenWidth = windowInfo.right - windowInfo.left;
    gameScreenLeftTopPoint = windowPoint;

    ref.read(gameScreenStateProvider.notifier).set(gameScreenWidth, gameScreenHeight,windowPoint);
    return 0;
  }

  factory OptionModule({int gameScreenWidth = 1280, int gameScreenHeight = 720,point = const Point(-1, -1)}) {
    return _instance ??= OptionModule._internal(gameScreenWidth, gameScreenHeight,point);
  }

  static OptionModule get instance {
    return _instance ??= OptionModule._internal(1280, 720,Point(-1,-1));
  }

  OptionModule._internal(this.gameScreenWidth,this.gameScreenHeight,this.gameScreenLeftTopPoint);
}



