import 'package:flutter/widgets.dart';

class VideoChangeNotifier extends ChangeNotifier {
  bool autoMute = true;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners();
  }
}

// 전역변수 선언
final videoChangeNotifier = VideoChangeNotifier();
