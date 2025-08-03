import 'dart:ffi';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:star_resonance_toolkit/core/model/window_info.dart';
import 'package:win32/win32.dart';



class Win32Util{
  static WindowInfo? getClientAreaRectByTitle(String windowTitle) {
    // 转换标题字符集
    final titlePtr = TEXT(windowTitle);

    try {
      // 根据标题查找窗口句柄
      final hwnd = FindWindow(nullptr, titlePtr);
      if (hwnd == 0) {
        return null;
      }

      // 获取窗口矩形
      final rect = calloc<RECT>();
      final success = GetClientRect(hwnd, rect);
      if (success == 0) {
        calloc.free(rect);
        return null;
      }

      final info = WindowInfo(rect.ref.left, rect.ref.top, rect.ref.right, rect.ref.bottom);
      calloc.free(rect);
      return info;
    } finally {
      calloc.free(titlePtr);
    }
  }

  static Point? getClientAreaTopLeft(String windowTitle) {
    final titlePtr = TEXT(windowTitle);

    try {
      // 根据标题查找窗口句柄
      final hwnd = FindWindow(nullptr, titlePtr);
      if (hwnd == 0) {
        return null;
      }

      // 客户区坐标 (0,0)
      final point = calloc<POINT>();
      point.ref.x = 0;
      point.ref.y = 0;

      // 转换为屏幕坐标
      final success = ClientToScreen(hwnd, point);
      if (success == 0) {
        calloc.free(point);
        return null;
      }

      final result = Point(point.ref.x, point.ref.y);
      calloc.free(point);
      return result;
    } finally {
      calloc.free(titlePtr);
    }
  }
}