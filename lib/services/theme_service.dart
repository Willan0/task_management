import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_management/constant/dao_constant.dart';

class ThemeDAO {
  final _themeBox = GetStorage();

  void _saveThemeToBox(bool isDarkMode) =>
      _themeBox.write(themeBoxKey, isDarkMode);
  bool _loodThemeFromBox() => _themeBox.read(themeBoxKey) ?? false;
  ThemeMode get theme => _loodThemeFromBox() ? ThemeMode.light : ThemeMode.dark;
  void switchTheme() {
    Get.changeThemeMode(theme);
    _saveThemeToBox(!_loodThemeFromBox());
  }
}
