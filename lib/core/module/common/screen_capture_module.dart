import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class ScreenCaptureModule {
  /// 截取屏幕指定区域，返回装有ARGB图片数据的Uint8List
  /// [x] 窗口客户区左上角x
  /// [y] 窗口客户区左上角y
  /// [width] 窗口客户区宽度
  /// [height] 窗口客户区高度
  static Future<Uint8List> capture(int x, int y, int width, int height) async{
    final hdcScreen = GetDC(NULL);
    final hdcMem = CreateCompatibleDC(hdcScreen);

    final hBitmap = CreateCompatibleBitmap(hdcScreen, width, height);
    if (hBitmap == NULL) {
      throw Exception('CompatibleBitmap创建失败');
    }

    final hOld = SelectObject(hdcMem, hBitmap);
    // 拷贝屏幕指定区域到内存DC
    final success = BitBlt(
      hdcMem,
      0,
      0,
      width,
      height,
      hdcScreen,
      x,
      y,
      SRCCOPY,
    );
    if (success == 0) {
      throw Exception('位图的内存拷贝失败');
    }

    // 定义位图信息，用于接收位图数据
    final bmi = calloc<BITMAPINFO>();
    bmi.ref.bmiHeader.biSize = sizeOf<BITMAPINFOHEADER>();
    bmi.ref.bmiHeader.biWidth = width;
    bmi.ref.bmiHeader.biHeight = -height; // 负值表示顶向下位图
    bmi.ref.bmiHeader.biPlanes = 1;
    bmi.ref.bmiHeader.biBitCount = 32; // 32位ARGB
    bmi.ref.bmiHeader.biCompression = BI_RGB;

    // 申请内存接收像素数据
    final length = width * height * 4;
    final pixels = calloc<Uint8>(length);

    // 从位图对象获取像素数据
    final scanLines = GetDIBits(
      hdcMem,
      hBitmap,
      0,
      height,
      pixels,
      bmi,
      DIB_RGB_COLORS,
    );
    if (scanLines == 0) {
      throw Exception('获取位图像素数据失败');
    }

    // 拷贝像素数据到dart的Uint8List容器
    final result = Uint8List.fromList(pixels.asTypedList(length));

    // 释放资源
    calloc.free(pixels);
    calloc.free(bmi);
    SelectObject(hdcMem, hOld);
    DeleteObject(hBitmap);
    DeleteDC(hdcMem);
    ReleaseDC(NULL, hdcScreen);

    return result;
  }
}