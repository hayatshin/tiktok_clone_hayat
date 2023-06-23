import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/features/authentication/widgets/login_form_screen.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "login";
  static String routeURL = "/login";

  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    context.pop();
    // Navigator.of(context).pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                "Log in to TikTok",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Gaps.v20,
              Opacity(
                opacity: 0.7,
                child: Text(
                  "Manage your account, check notifications, comment on videos, and more.",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v16,
              GestureDetector(
                onTap: () => _onEmailLoginTap(context),
                child: AuthButton(
                  icon: const FaIcon(FontAwesomeIcons.user),
                  text: "Use email & password",
                  callback: () => _onEmailLoginTap(context),
                ),
              ),
              Gaps.v20,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.apple),
                text: "Continue with Apple",
                callback: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size20,
            bottom: Sizes.size40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
