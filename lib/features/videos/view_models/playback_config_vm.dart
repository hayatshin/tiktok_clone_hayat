import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final VideoPlaybackConfigRepository _repository;
  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.isMuted(),
    autoPlay: _repository.isAutoplay(),
  );

  PlaybackConfigViewModel(this._repository);

  bool get muted => _model.muted;
  bool get autoplay => _model.autoPlay;

  void setMuted(bool value) {
    // persist data
    _repository.setMuted(value);

    // modify data
    _model.muted = value;

    // notify to view
    notifyListeners();
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    _model.autoPlay = value;
    notifyListeners();
  }
}
