import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class SimulationModule{
  /// 传入全屏幕的绝对坐标值，是瞬移过去的
  static void moveMouseTo(int endX, int endY) {
    final inputs = calloc<INPUT>();
    inputs.ref.type = INPUT_MOUSE;

    // 转换坐标到 0 - 65535（绝对坐标系）
    final screenWidth = GetSystemMetrics(SM_CXSCREEN);
    final screenHeight = GetSystemMetrics(SM_CYSCREEN);

    inputs.ref.mi.dx = (endX * 65535 ~/ screenWidth);
    inputs.ref.mi.dy = (endY * 65535 ~/ screenHeight);
    inputs.ref.mi.dwFlags = MOUSEEVENTF_MOVE | MOUSEEVENTF_ABSOLUTE;

    SendInput(1, inputs, sizeOf<INPUT>());
    calloc.free(inputs);
  }

  /// 传入全屏幕的绝对坐标值，是多步移动过去的
  static void smoothMouseTo(int endX, int endY, {int steps = 20, int delayMs = 700}) async{
    final p = calloc<POINT>();
    GetCursorPos(p);
    final startX = p.ref.x;
    final startY = p.ref.y;
    calloc.free(p);

    final dx = (endX - startX) / steps;
    final dy = (endY - startY) / steps;

    for (int i = 1; i <= steps; i++) {
      final nextX = startX + (dx * i).round();
      final nextY = startY + (dy * i).round();
      moveMouseTo(nextX, nextY);
      await Future.delayed(Duration(milliseconds: delayMs));
    }
  }

  /// 设置延迟
  static Future<void> setDelayTime({int delayMs = 75}){
    return Future.delayed(Duration(milliseconds: delayMs));
  }

  /// 鼠标左键按下
  static void pressMouseLeft() {
    final inputs = calloc<INPUT>();

    inputs.ref.type = INPUT_MOUSE;
    inputs.ref.mi.dwFlags = MOUSEEVENTF_LEFTDOWN;

    SendInput(1, inputs, sizeOf<INPUT>());
    calloc.free(inputs);
  }

  /// 鼠标左键抬起
  static void releaseMouseLeft() {
    final inputs = calloc<INPUT>();

    inputs.ref.type = INPUT_MOUSE;
    inputs.ref.mi.dwFlags = MOUSEEVENTF_LEFTUP;

    SendInput(1, inputs, sizeOf<INPUT>());
    calloc.free(inputs);

  }

  /// 键盘按键按下
  static void pressKey(int virtualKeyCode) {
    final inputs = calloc<INPUT>();

    inputs.ref.type = INPUT_KEYBOARD;
    inputs.ref.ki.wVk = virtualKeyCode;
    inputs.ref.ki.dwFlags = 0;

    SendInput(1, inputs, sizeOf<INPUT>());
    calloc.free(inputs);
  }

  /// 键盘按键抬起
  static void releaseKey(int virtualKeyCode){
    final inputs = calloc<INPUT>();

    inputs.ref.type = INPUT_KEYBOARD;
    inputs.ref.ki.wVk = virtualKeyCode;
    inputs.ref.ki.dwFlags = KEYEVENTF_KEYUP;

    SendInput(1, inputs, sizeOf<INPUT>());
    calloc.free(inputs);
  }
}