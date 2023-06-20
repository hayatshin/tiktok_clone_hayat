import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          CupertinoSwitch(
            value: _notification,
            onChanged: _onNotificationChanged,
          ),
          SwitchListTile(
            value: _notification,
            onChanged: _onNotificationChanged,
            title: const Text(
              "Enable notifications",
            ),
          ),
          CheckboxListTile(
            value: _notification,
            onChanged: _onNotificationChanged,
            title: const Text("Enable notifications"),
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
