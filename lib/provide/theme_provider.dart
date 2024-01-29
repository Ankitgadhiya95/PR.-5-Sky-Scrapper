import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool theme = false;
  late SharedPreferences introscreen;

  get isDarkMethod {
    return theme;
  }

  ThemeProvider() {
    getThemeMode();
  }

  set setDarkTheme(bool value) {
    theme = !value;
    setThemeMode(!value);
    notifyListeners();
  }

  setThemeMode(value) async {
    introscreen = await SharedPreferences.getInstance();
    introscreen.setBool('theme', value);
  }

  getThemeMode() async {
    introscreen = await SharedPreferences.getInstance();
    theme = introscreen.getBool('theme') ?? false;
    notifyListeners();
  }
}
