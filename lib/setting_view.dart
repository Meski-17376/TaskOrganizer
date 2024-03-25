import 'package:flutter/material.dart';
import 'customization.dart'; // Your Customization class

class SettingsView extends StatefulWidget {
   const SettingsView({super.key});
  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  bool _isDarkMode = false;
  final Customization customization = Customization();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _isDarkMode = await customization.getThemeMode();
    setState(() {});
  }

  Future<void> _updateThemeMode(bool newValue) async {
    await customization.setThemeMode(newValue);
    setState(() {
      _isDarkMode = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: _updateThemeMode,
          ),
          // Add more settings options here
        ],
      ),
    );
  }
}
