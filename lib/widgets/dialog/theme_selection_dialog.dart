import 'package:flutter/material.dart';

enum Theme { light, dark }

class ThemeSelectionDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ThemeSelectionDialogState();
}

class ThemeSelectionDialogState extends State<ThemeSelectionDialog> {
  Theme? _theme;

  ThemeSelectionDialogState()
      : _theme = Theme.light,
        super();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Theme"),
      children: [
        RadioListTile(
            title: const Text("Light"),
            value: Theme.light,
            groupValue: _theme,
            onChanged: _onChanged),
        RadioListTile(
            title: const Text("Dark"),
            value: Theme.dark,
            groupValue: _theme,
            onChanged: _onChanged)
      ],
    );
  }

  void _onChanged(Theme? value) {
    setState(() {
      _theme = value;
    });
  }
}
