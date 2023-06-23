import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";
  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              Container(
                color: Colors.transparent,
                width: Sizes.size40 + Sizes.size12,
                height: Sizes.size60,
              ),
              const Positioned(
                top: 5,
                left: 0,
                child: CircleAvatar(
                  radius: Sizes.size20,
                  foregroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzwyqpjAmQf9cJZJYedogG6ivGM_FAyiIOwQ&usqp=CAU",
                  ),
                  child: Text("니꼬"),
                ),
              ),
              Positioned(
                top: 25,
                left: 25,
                child: Container(
                  width: Sizes.size20,
                  height: Sizes.size20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade300,
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            "니꼬 ${widget.chatId}",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              )
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size20,
                  horizontal: Sizes.size14,
                ),
                itemBuilder: (context, index) {
                  final isMine = index % 2 == 0;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: isMine
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          Sizes.size14,
                        ),
                        decoration: BoxDecoration(
                          color: isMine
                              ? Colors.blue
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(
                                Sizes.size20,
                              ),
                              topRight: const Radius.circular(
                                Sizes.size20,
                              ),
                              bottomLeft: Radius.circular(
                                isMine ? Sizes.size20 : Sizes.size5,
                              ),
                              bottomRight: Radius.circular(
                                !isMine ? Sizes.size20 : Sizes.size5,
                              )),
                        ),
                        child: const Text(
                          "This is a message",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: 10),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                  color: Colors.grey.shade50,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: Sizes.size12,
                              horizontal: Sizes.size20,
                            ),
                            hintText: "Send a message...",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: Sizes.size18,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Sizes.size10),
                                bottomLeft: Radius.circular(Sizes.size10),
                                topRight: Radius.circular(Sizes.size10),
                              ),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            suffixIcon: const FaIcon(
                              FontAwesomeIcons.faceSmile,
                            ),
                            suffixIconConstraints: const BoxConstraints(
                              minWidth: Sizes.size40,
                              minHeight: Sizes.size10,
                            ),
                          ),
                        ),
                      ),
                      Gaps.h20,
                      Container(
                        padding: const EdgeInsets.all(
                          Sizes.size12,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade400,
                        ),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.solidPaperPlane,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
