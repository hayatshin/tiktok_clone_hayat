import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  static const String routeName = "activity";
  static const String routeURL = "/activity";
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    }
  ];

  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _arrowAnimation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  late final Animation<Offset> _panelAnimation = Tween(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  @override
  void initState() {
    super.initState();
  }

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  void _toggleAnimations() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h4,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v14,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                ),
                child: Text(
                  "New",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Gaps.v14,
              Expanded(
                child: ListView.builder(
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        child: Dismissible(
                          key: Key(_notifications[index]),
                          onDismissed: (direction) =>
                              _onDismissed(_notifications[index]),
                          background: Container(
                            alignment: Alignment.centerLeft,
                            color: Colors.green,
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: Sizes.size10,
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.checkDouble,
                                color: Colors.white,
                                size: Sizes.size32,
                              ),
                            ),
                          ),
                          secondaryBackground: Container(
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.only(
                                right: Sizes.size10,
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.trashCan,
                                color: Colors.white,
                                size: Sizes.size32,
                              ),
                            ),
                          ),
                          child: ListTile(
                            // leading: const CircleAvatar(
                            //   child: FaIcon(FontAwesomeIcons.bell),
                            // ),
                            minVerticalPadding: Sizes.size16,
                            leading: Container(
                              width: Sizes.size52,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    width: Sizes.size1,
                                  )),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.bell,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            // title: const Row(
                            //   children: [
                            //     Text(
                            //       "Account updates: ",
                            //       style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     Text(
                            //       "Upload longer",
                            //       style: TextStyle(),
                            //     ),
                            //   ],
                            // ),
                            title: RichText(
                              text: TextSpan(
                                text: "Account Updates: ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: Sizes.size16,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "Upload longer videos ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text: _notifications[index],
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // subtitle: Row(
                            //   children: [
                            //     Text(
                            //       "1h",
                            //       style: TextStyle(
                            //         color: Colors.grey.shade500,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            trailing: const FaIcon(
                              FontAwesomeIcons.chevronRight,
                              size: Sizes.size16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true,
              onDismiss: _toggleAnimations,
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    Sizes.size5,
                  ),
                  bottomRight: Radius.circular(
                    Sizes.size5,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          FaIcon(
                            tab["icon"],
                            color: Colors.black,
                            size: Sizes.size16,
                          ),
                          Gaps.h20,
                          Text(
                            tab["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
