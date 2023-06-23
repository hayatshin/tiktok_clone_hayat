import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/email_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameControllder = TextEditingController();

  String _username = "";

  @override
  void initState() {
    super.initState();

    _usernameControllder.addListener(() {
      setState(() {
        _username = _usernameControllder.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameControllder.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (_username.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailScreen(username: _username),
      ),
    );

    // context.pushNamed(
    //   EmailScreen.routeName,
    //   extra: EmailScreenArgs(
    //     username: _username,
    //   ),
    // );

    /* Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailScreen(),
      ),
    ); */

    /*  Navigator.pushNamed(
      context,
      EmailScreen.routeName,
      arguments: EmailScreenArgs(
        username: _username,
      ),
    ); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameControllder,
              decoration: InputDecoration(
                hintText: "Username",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            GestureDetector(
              onTap: _onNextTap,
              child: FormButton(disabled: _username.isEmpty),
            )
          ],
        ),
      ),
    );
  }
}
