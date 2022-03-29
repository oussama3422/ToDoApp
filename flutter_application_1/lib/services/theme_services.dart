import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _box = GetStorage();
  final _key = 'checkModeTheme';

  bool _loadThemeFromBox() {
    return false;
  }

  bool _saveThemeToBox() {
    
    return false;
  }

  ThemeMode get theme {
    return _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() {}
}
