
import 'package:flutter/services.dart';

class AssetsUtil{
  static const Map<String, String> assetsImageMap = {
    'left_arrow.png': 'assets/images/fishing/left_arrow.png',
    'right_arrow.png': 'assets/images/fishing/right_arrow.png',
    'fish_hook.png': 'assets/images/fishing/fish_hook.png',
    'continue_fishing_button.png': 'assets/images/fishing/continue_fishing_button.png'
  };

  static Future<Map<String, Uint8List>> loadAllImages() async {
    final Map<String, Uint8List> result = {};
    for (final entry in assetsImageMap.entries) {
      final byteData = await rootBundle.load(entry.value);
      Uint8List uint8list = byteData.buffer.asUint8List();
      result[entry.key] = uint8list;
    }
    return result;
  }
  static Future<ByteData?> loadImage(String path) async{
    return await rootBundle.load(path);
  }
}