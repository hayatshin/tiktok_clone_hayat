import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/widgets/video_config/dark_config.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_account.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool isDark = darkConfig.value;

    darkConfig.addListener(() {
      setState(() {
        isDark = darkConfig.value;
      });
    });

    return Scaffold(
      body: Container(
        color: isDark ? Colors.black : Colors.white,
        child: SafeArea(
          child: DefaultTabController(
            initialIndex: widget.tab == "likes" ? 1 : 0,
            length: 2,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      centerTitle: true,
                      title: Text(widget.username),
                      actions: [
                        IconButton(
                          onPressed: _onGearPressed,
                          icon: const FaIcon(
                            FontAwesomeIcons.gear,
                            size: Sizes.size20,
                          ),
                        )
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: width < Breakpoints.md
                          ? Column(
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  foregroundColor: Colors.teal,
                                  foregroundImage: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzwyqpjAmQf9cJZJYedogG6ivGM_FAyiIOwQ&usqp=CAU"),
                                  child: Text("니꼬"),
                                ),
                                Gaps.v20,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "@${widget.username}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: Sizes.size18,
                                      ),
                                    ),
                                    Gaps.h8,
                                    FaIcon(
                                      FontAwesomeIcons.solidCircleCheck,
                                      size: Sizes.size16,
                                      color: Colors.blue.shade500,
                                    )
                                  ],
                                ),
                                Gaps.v24,
                                SizedBox(
                                  height: Sizes.size52,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const UserAcount(
                                          number: "97",
                                          numberType: "Following"),
                                      VerticalDivider(
                                        width: Sizes.size32,
                                        thickness: Sizes.size1,
                                        color: Colors.grey.shade400,
                                        indent: Sizes.size12,
                                        endIndent: Sizes.size12,
                                      ),
                                      const UserAcount(
                                          number: "10M",
                                          numberType: "Followers"),
                                      VerticalDivider(
                                        width: Sizes.size32,
                                        thickness: Sizes.size1,
                                        color: Colors.grey.shade400,
                                        indent: Sizes.size12,
                                        endIndent: Sizes.size12,
                                      ),
                                      const UserAcount(
                                          number: "194.3M",
                                          numberType: "Likes"),
                                    ],
                                  ),
                                ),
                                Gaps.v14,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size24,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: Sizes.size40,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: Sizes.size12,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                Sizes.size4,
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            "Follow",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Gaps.h10,
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1.0,
                                              color: Colors.grey.shade500,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(Sizes.size3),
                                            ),
                                          ),
                                          child: const Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.youtube,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Gaps.h10,
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1.0,
                                              color: Colors.grey.shade500,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(Sizes.size3),
                                            ),
                                          ),
                                          child: const Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.caretDown,
                                              size: Sizes.size16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gaps.v14,
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Sizes.size32,
                                  ),
                                  child: Text(
                                    "All highlights and where to watch live matches on FIFA+",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Gaps.v14,
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.link,
                                      size: Sizes.size12,
                                    ),
                                    Gaps.h4,
                                    Text(
                                      "https://nomadcoders.co",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.v20,
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          foregroundColor: Colors.teal,
                                          foregroundImage: NetworkImage(
                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzwyqpjAmQf9cJZJYedogG6ivGM_FAyiIOwQ&usqp=CAU"),
                                          child: Text("니꼬"),
                                        ),
                                      ],
                                    ),
                                    Gaps.h60,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "@니꼬",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Sizes.size18,
                                              ),
                                            ),
                                            Gaps.h8,
                                            FaIcon(
                                              FontAwesomeIcons.solidCircleCheck,
                                              size: Sizes.size16,
                                              color: Colors.blue.shade500,
                                            )
                                          ],
                                        ),
                                        Gaps.v24,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const UserAcount(
                                                number: "97",
                                                numberType: "Following"),
                                            VerticalDivider(
                                              width: Sizes.size32,
                                              thickness: Sizes.size1,
                                              color: Colors.grey.shade400,
                                              indent: Sizes.size12,
                                              endIndent: Sizes.size12,
                                            ),
                                            const UserAcount(
                                                number: "10M",
                                                numberType: "Followers"),
                                            VerticalDivider(
                                              width: Sizes.size32,
                                              thickness: Sizes.size1,
                                              color: Colors.grey.shade400,
                                              indent: Sizes.size12,
                                              endIndent: Sizes.size12,
                                            ),
                                            const UserAcount(
                                                number: "194.3M",
                                                numberType: "Likes"),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Gaps.h80,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Gaps.h10,
                                        SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1.0,
                                                color: Colors.grey.shade500,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(Sizes.size3),
                                              ),
                                            ),
                                            child: const Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.youtube,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Gaps.h10,
                                        SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1.0,
                                                color: Colors.grey.shade500,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(Sizes.size3),
                                              ),
                                            ),
                                            child: const Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.caretDown,
                                                size: Sizes.size16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Gaps.v40,
                                FractionallySizedBox(
                                  widthFactor: 0.6,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Sizes.size12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          Sizes.size4,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Follow",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Gaps.v40,
                                const Text(
                                  "All highlights and where to watch live matches on FIFA+",
                                  textAlign: TextAlign.center,
                                ),
                                Gaps.v14,
                                const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.link,
                                      size: Sizes.size12,
                                    ),
                                    Gaps.h4,
                                    Text(
                                      "https://nomadcoders.co",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.v40,
                              ],
                            ),
                    ),
                    SliverPersistentHeader(
                      delegate: PersistentTabBar(),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    GridView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: 20,
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size6,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: Sizes.size2,
                        mainAxisSpacing: Sizes.size2,
                        childAspectRatio: 9 / 14,
                      ),
                      itemBuilder: (context, index) => Stack(
                        children: [
                          Positioned.fill(
                            top: 0,
                            left: 0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 14,
                                  child: FadeInImage.assetNetwork(
                                      placeholderFit: BoxFit.cover,
                                      fit: BoxFit.cover,
                                      placeholder: "assets/images/tree.jpg",
                                      image:
                                          "https://media.istockphoto.com/id/944812540/ko/%EC%82%AC%EC%A7%84/%EC%82%B0-%ED%94%84%EB%A6%AC-%ED%8F%B0-%ED%83%80-%EB%8D%B8%EA%B0%80-%EB%8B%A4-%EC%84%AC-%EC%95%84%EC%A1%B0%EB%A0%88%EC%8A%A4-%EC%A0%9C%EB%8F%84.jpg?s=612x612&w=0&k=20&c=DQJ6eA0Wnxqt1yDdJChcoyuJ_5r0IQBduoIFZY0QV78="),
                                ),
                              ],
                            ),
                          ),
                          const Positioned.fill(
                            bottom: 0,
                            left: 0,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.caretRight,
                                      color: Colors.white,
                                      size: Sizes.size24,
                                    ),
                                    Gaps.h14,
                                    Text(
                                      "4.1M",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: Sizes.size18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text("hi")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
