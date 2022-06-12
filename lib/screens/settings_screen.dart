import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../widgets/dialog/theme_selection_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SettingsList(sections: [
        SettingsSection(tiles: <SettingsTile>[
          SettingsTile.navigation(
            onPressed: (context) => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ThemeSelectionDialog();
                  })
            },
            leading: const Icon(Icons.format_paint_outlined),
            title: const Text("Theme"),
            description: const Text("Change the theme of the app"),
          )
        ])
      ]),
    );
  }
}
