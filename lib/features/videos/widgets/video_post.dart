import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_value_notifier.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _vidoPlayerControllder;
  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;
  bool _seeMoreShowOrNot = true;
  final String _initialVideoDescription = "This is my house in Tahiland!!";
  String _videoDescription = "";

  bool _isPaused = false;
  bool _isMuted = true;
  // bool _autoMute = videoChangeNotifier.autoMute;
  bool _autoMute = videoValueNotifier.value;

  void _onVideoChange() {
    if (!mounted) return;
    if (_vidoPlayerControllder.value.isInitialized) {
      if (_vidoPlayerControllder.value.duration ==
          _vidoPlayerControllder.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _vidoPlayerControllder =
        VideoPlayerController.asset("assets/videos/hyean.mp4");
    await _vidoPlayerControllder.initialize();
    await _vidoPlayerControllder.setLooping(true);

    if (kIsWeb) {
      await _vidoPlayerControllder.setVolume(0);
      setState(() {
        _isMuted = true;
      });
    }
    _vidoPlayerControllder.addListener(_onVideoChange);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    _animationController.addListener(() {
      setState(() {});
    });

    if (_initialVideoDescription.length > 5) {
      setState(() {
        _seeMoreShowOrNot = true;
        _videoDescription = "${_initialVideoDescription.substring(0, 5)}...";
      });
    } else {
      setState(() {
        _seeMoreShowOrNot = false;
        _videoDescription = _initialVideoDescription;
      });
    }

    // videoChangeNotifier.addListener(() {
    //   setState(() {
    //     _autoMute = videoChangeNotifier.autoMute;
    //   });
    // });

    videoValueNotifier.addListener(() {
      setState(() {
        _autoMute = videoValueNotifier.value;
      });
    });
  }

  @override
  void dispose() {
    _vidoPlayerControllder.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_vidoPlayerControllder.value.isPlaying) {
      _vidoPlayerControllder.play();
    }
    if (_vidoPlayerControllder.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_vidoPlayerControllder.value.isPlaying) {
      _vidoPlayerControllder.pause();
      _animationController.reverse();
    } else {
      _vidoPlayerControllder.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onSeeMoreDescription() {
    if (_videoDescription.length > 5) {
      setState(() {
        _seeMoreShowOrNot = false;
        _videoDescription = _initialVideoDescription;
      });
    }
  }

  void _onCommentsTap(BuildContext context) async {
    if (_vidoPlayerControllder.value.isPlaying) {
      _onTogglePause();
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );

    _onTogglePause();
  }

  void _onToggleVolume() {
    if (_isMuted) {
      _vidoPlayerControllder.setVolume(100);
    } else {
      _vidoPlayerControllder.setVolume(0);
    }
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  @override
  Widget build(BuildContext context) {
    // bool settingMute = VideoConfigData.of(context).autoMute;
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _vidoPlayerControllder.value.isInitialized
                ? VideoPlayer(_vidoPlayerControllder)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
              child: GestureDetector(
            onTap: _onTogglePause,
          )),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, chlid) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: chlid,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "@니꼬",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Row(
                  children: [
                    Text(
                      _videoDescription,
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.white,
                      ),
                    ),
                    Visibility(
                      visible: _seeMoreShowOrNot,
                      child: GestureDetector(
                        onTap: () => _onSeeMoreDescription(),
                        child: const Text(
                          "...See more",
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                // 볼륨 조절
                GestureDetector(
                  onTap: _onToggleVolume,
                  child: FaIcon(
                    context.watch<VideoProvider>().isMuted
                        ? FontAwesomeIcons.volumeXmark
                        : _isMuted
                            ? FontAwesomeIcons.volumeHigh
                            : FontAwesomeIcons.volumeXmark,
                    size: Sizes.size40,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Gaps.v24,
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  foregroundImage: NetworkImage(
                    "https://cdn.icon-icons.com/icons2/1879/PNG/512/iconfinder-8-avatar-2754583_120515.png",
                  ),
                  radius: 25,
                  child: Text(
                    "니꼬",
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "2.9M",
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "33K",
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
