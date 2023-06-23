import 'package:flutter/widgets.dart';

class VideoProvider extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}
