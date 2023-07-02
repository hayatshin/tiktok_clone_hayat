import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final _videoId;
  late final _likeOrNot;

  Future<bool> get likeOrNot => _likeOrNot;

  @override
  FutureOr<void> build(String videoId) {
    _videoId = videoId;
    _repository = ref.read(videosRepo);

    final user = ref.read(authRepo).user;
    _likeOrNot = ref.read(videosRepo).initialLikeVideo(videoId, user!.uid);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _repository.likeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
        () => VideoPostViewModel());
