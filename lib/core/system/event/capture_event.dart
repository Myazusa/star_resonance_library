import 'dart:typed_data';

class CaptureEvent{
  Uint8List screenCaptureImage;
  String fileName;

  CaptureEvent(this.screenCaptureImage, this.fileName);
}