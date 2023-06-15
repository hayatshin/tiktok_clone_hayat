import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});
  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  bool _isWriting = false;

  late TabController _tabController;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");

  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSubmitted(String value) {
    print(value);
  }

  void _onGoBackHistory() {
    Navigator.of(context).pop();
  }

  void _hideKeyBoard() {
    if (_tabController.indexIsChanging) {
      FocusScope.of(context).unfocus();
    }
  }

  void _onTypingTextCheck(value) {
    setState(() {
      _isWriting = value.isNotEmpty;
    });
  }

  void _onTapXmark() {
    _textEditingController.clear();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_hideKeyBoard);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.removeListener(_hideKeyBoard);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size2,
              vertical: Sizes.size4,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _onGoBackHistory,
                  child: const FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: Sizes.size24,
                  ),
                ),
                Gaps.h10,
                Expanded(
                  child: SizedBox(
                    width: size.width,
                    height: Sizes.size48,
                    child: TextField(
                      onChanged: _onTypingTextCheck,
                      focusNode: _focusNode,
                      minLines: null,
                      maxLines: null,
                      expands: true,
                      controller: _textEditingController,
                      textInputAction: TextInputAction.newline,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        // hintText: "input",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Sizes.size10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size10,
                          vertical: Sizes.size10,
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 10,
                        ),
                        suffixIcon: _isWriting
                            ? GestureDetector(
                                onTap: _onTapXmark,
                                child: const FaIcon(
                                  FontAwesomeIcons.solidCircleXmark,
                                  color: Colors.grey,
                                  size: Sizes.size24,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                Gaps.h10,
                const FaIcon(
                  FontAwesomeIcons.sliders,
                  size: Sizes.size24,
                )
              ],
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                )
            ],
          ),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _focusNode.unfocus();
          },
          child: TabBarView(
            controller: _tabController,
            children: [
              GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 20,
                padding: const EdgeInsets.all(
                  Sizes.size6,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 9 / 18,
                ),
                itemBuilder: (context, index) => Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Sizes.size4,
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 13,
                        child: FadeInImage.assetNetwork(
                            placeholderFit: BoxFit.cover,
                            fit: BoxFit.cover,
                            placeholder: "assets/images/tree.jpg",
                            image:
                                "https://media.istockphoto.com/id/944812540/ko/%EC%82%AC%EC%A7%84/%EC%82%B0-%ED%94%84%EB%A6%AC-%ED%8F%B0-%ED%83%80-%EB%8D%B8%EA%B0%80-%EB%8B%A4-%EC%84%AC-%EC%95%84%EC%A1%B0%EB%A0%88%EC%8A%A4-%EC%A0%9C%EB%8F%84.jpg?s=612x612&w=0&k=20&c=DQJ6eA0Wnxqt1yDdJChcoyuJ_5r0IQBduoIFZY0QV78="),
                      ),
                    ),
                    Gaps.v10,
                    const Text(
                      "This is a very long caption for my tiktok that im upload just now currently.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Sizes.size16 + Sizes.size2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v8,
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                                "https://cdn.icon-icons.com/icons2/1879/PNG/512/iconfinder-8-avatar-2754583_120515.png"),
                          ),
                          Gaps.h4,
                          const Expanded(
                            child: Text(
                              "Burnt_Pellet_Hayat_HyejungShin",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Gaps.h4,
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size16,
                            color: Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          const Text(
                            "2.5M",
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              for (var tab in tabs.skip(1))
                Center(
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
