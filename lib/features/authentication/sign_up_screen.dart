import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  static const routeURL = "/";
  static const routeName = "signUp";
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    context.pushNamed(LoginScreen.routeName);

    // final result = await Navigator.of(context).pushNamed(LoginScreen.routeName);

    // final result = await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const LoginScreen(),
    //   ),
    // );
  }

  void _onEmailTap(BuildContext context) {
    // context.pushNamed(UsernameScreen.routeName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );

    // context.push(UsernameScreen.routeName);
    // context.push("/users/lynn?show=likes");

    // Navigator.of(context).pushNamed(UsernameScreen.routeName);

    // Navigator.of(context).push(
    // MaterialPageRoute(
    //   builder: (context) => const UsernameScreen(),
    // ),

    /* PageRouteBuilder(
        transitionDuration: const Duration(
          seconds: 1,
        ),
        reverseTransitionDuration: const Duration(
          seconds: 1,
        ),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const UsernameScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation);
          final opacityAnimation = Tween(
            begin: 0.5,
            end: 0.8,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: opacityAnimation,
              child: child,
            ),
          );
        },
      ), */

    // );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        print(orientation);
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
                    "Sign up for TikTok",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      "Create a profile, follow other accounts, make your own videos, and more.",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v16,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.user),
                      text: "Use email & password",
                      callback: () => _onEmailTap(context),
                    ),
                    Gaps.v20,
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.apple),
                      text: "Continue with Apple",
                      callback: () {},
                    )
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.user),
                            text: "Use email & password",
                            callback: () => _onEmailTap(context),
                          ),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.apple),
                            text: "Continue with Apple",
                            callback: () {},
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            // color: Colors.grey.shade50,
            // elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size20,
                bottom: Sizes.size40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      "Log in",
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
      },
    );
  }
}
