import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/dark_config.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notification = false;

  void _onNotificationChanged(bool? newvalue) {
    if (newvalue == null) return;
    setState(() {
      _notification = newvalue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: context.watch<PlaybackConfigViewModel>().muted,
            onChanged: (value) =>
                context.read<PlaybackConfigViewModel>().setMuted(value),
            title: const Text(
              "Mute video",
            ),
          ),
          SwitchListTile(
            value: context.watch<PlaybackConfigViewModel>().autoplay,
            onChanged: (value) =>
                context.read<PlaybackConfigViewModel>().setAutoplay(value),
            title: const Text(
              "Auto play",
            ),
          ),
          // provider
          AnimatedBuilder(
            animation: darkConfig,
            builder: (context, child) => SwitchListTile(
              value: darkConfig.value,
              onChanged: (value) {
                darkConfig.value = !darkConfig.value;
              },
              title: const Text(
                "DarkMode",
              ),
              subtitle: const Text("you can set up dark mode."),
            ),
          ),
          // SwitchListTile(
          //   value: context.watch<VideoProvider>().isMuted,
          //   onChanged: (value) => context.read<VideoProvider>().toggleIsMuted(),
          //   title: const Text(
          //     "Enable notifications",
          //   ),
          // ),
          // ValueNotifier
          /*  AnimatedBuilder(
            animation: videoChangeNotifier,
            builder: (context, child) => SwitchListTile(
              value: videoValueNotifier.value,
              onChanged: (value) {
                videoValueNotifier.value = !videoValueNotifier.value;
              },
              title: const Text(
                "Auto Mute",
              ),
              subtitle: const Text("Videos will be muted by default."),
            ),
          ), */

          // ChangeNotifier
          /*  AnimatedBuilder(
            animation: videoChangeNotifier,
            builder: (context, child) => SwitchListTile(
              value: videoChangeNotifier.autoMute,
              onChanged: (value) {
                videoChangeNotifier.toggleAutoMute();
              },
              title: const Text(
                "Auto Mute",
              ),
              subtitle: const Text("Videos will be muted by default."),
            ),
          ), */

          // InheritedWidget
          /* SwitchListTile(
            value: VideoConfigData.of(context).autoMute,
            onChanged: (value) {
              VideoConfigData.of(context).toggleMuted();
            },
            title: const Text(
              "Auto Mute",
            ),
            subtitle: const Text("Videos will be muted by default."),
          ), */
          SwitchListTile(
            value: _notification,
            onChanged: _onNotificationChanged,
            title: const Text(
              "Enable notifications",
            ),
          ),
          /* CupertinoSwitch(
            value: _notification,
            onChanged: _onNotificationChanged,
          ), */
          CheckboxListTile(
            value: _notification,
            onChanged: _onNotificationChanged,
            title: const Text("Enable notifications"),
            subtitle: const Text("They will be cute."),
            activeColor: Colors.black,
          ),
          ListTile(
            onTap: () => showAboutDialog(
              context: context,
              applicationVersion: "1.0",
              applicationLegalese: "All rights reserved.",
            ),
            title: const Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text("About this app.."),
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
              );
              print(date);
            },
            title: const Text(
              "what is your birthday?",
            ),
          ),
          ListTile(
            title: const Text("Log out (iOS)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Please don't go"),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text("No"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (iOS / Bottom)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text("Are you sure?"),
                  actions: [
                    TextButton(
                      child: const Text("No"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text("Yes"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
          const AboutListTile(),
        ],
      ),
    );
  }
}
