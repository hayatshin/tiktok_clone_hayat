import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

import '../authentication/widgets/form_button.dart';

class UserSettingScreen extends ConsumerStatefulWidget {
  final String username;

  const UserSettingScreen({super.key, required this.username});

  @override
  ConsumerState<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends ConsumerState<UserSettingScreen> {
  String _bio = "";
  String _link = "";
  final TextEditingController bioController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  @override
  void dispose() {
    bioController.dispose();
    linkController.dispose();
    super.dispose();
  }

  void _onUserProfileSubmit(WidgetRef ref, String uid) async {
    await ref.read(userRepo).updateUser(uid, {
      "bio": bioController.text,
      "link": linkController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
        error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
        data: (data) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text(widget.username),
            ),
            body: Padding(
              padding: const EdgeInsets.all(
                Sizes.size40,
              ),
              child: FutureBuilder(
                future: ref.read(userRepo).findProfile(data.uid),
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "bio",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextField(
                        controller: bioController,
                        onChanged: (value) {
                          setState(() {
                            _bio = snapshot.data?["bio"];
                          });
                        },
                        decoration: InputDecoration(
                          labelText: snapshot.data?["bio"] == null ||
                                  snapshot.data?["bio"] == "undefined"
                              ? "write your bio"
                              : snapshot.data!["bio"],
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Gaps.v40,
                      const Text(
                        "link",
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextField(
                        controller: linkController,
                        onChanged: (value) {
                          setState(() {
                            _link = snapshot.data?["link"];
                          });
                        },
                        decoration: InputDecoration(
                          labelText: snapshot.data?["link"] == null ||
                                  snapshot.data?["link"] == "undefined"
                              ? "write your link"
                              : snapshot.data!["link"],
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Gaps.v40,
                      GestureDetector(
                        onTap: () => _onUserProfileSubmit(ref, data.uid),
                        child: FormButton(
                          disabled: _bio.isEmpty || _link.isEmpty,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          );
        });
  }
}
