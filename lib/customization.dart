import 'package:shared_preferences/shared_preferences.dart';

class Customization {
  static const _themeModeKey = 'themeMode';

  Future<void> setThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeModeKey, isDarkMode);
  }

  Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeModeKey) ?? false; // Default to light mode
  }
}
