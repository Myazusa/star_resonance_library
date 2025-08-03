
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_screen_state.g.dart';

@Riverpod(keepAlive: true)
class GameScreenState extends _$GameScreenState {
  @override
  GameScreen build() => GameScreen(width: 0,height: 0,point: Point(-1, -1));

  void set(int width,int height,Point point) => state = GameScreen(width: width,height: height,point: point);
}

class GameScreen {
  final int width;
  final int height;
  final Point point;

  GameScreen({required this.width, required this.height,required this.point});
}