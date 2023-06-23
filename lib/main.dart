import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/dark_config.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_provider.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(const TikTokApp());
}

class TikTokApp extends StatefulWidget {
  const TikTokApp({super.key});

  @override
  State<TikTokApp> createState() => _TikTokAppState();
}

class _TikTokAppState extends State<TikTokApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool darkTheme = darkConfig.value;

    darkConfig.addListener(() {
      setState(() {
        darkTheme = darkConfig.value;
      });
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VideoProvider(),
        ),
        ValueListenableProvider.value(
          value: darkConfig,
        )
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // themeMode: ThemeMode.dark,
        themeMode: darkTheme ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          useMaterial3: true,
          // textTheme: GoogleFonts.itimTextTheme(),
          textTheme: Typography.blackMountainView,
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 1,
            titleTextStyle: TextStyle(
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            surfaceTintColor: Colors.white,
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade50,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFE9435A),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          splashColor: Colors.transparent,
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          // textTheme: GoogleFonts.itimTextTheme(
          //   ThemeData(brightness: Brightness.dark).textTheme,
          // ),
          // textTheme: const TextTheme(
          //   headlineLarge: TextStyle(
          //     fontSize: Sizes.size24,
          //     fontWeight: FontWeight.w700,
          //     color: Colors.white,
          //   ),
          // ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.white,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.black,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
            iconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
          ),
          textTheme: Typography.whiteMountainView,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFFE9435A),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          ),
        ),
        // home: const SignUpScreen(),

        /*  initialRoute: SignUpScreen.routeName,
        routes: {
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          UsernameScreen.routeName: (context) => const UsernameScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          EmailScreen.routeName: (context) => EmailScreen(username: username),
        }, */
      ),
    );
  }
}
