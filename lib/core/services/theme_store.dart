import 'package:exchange/core/resources/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStore {
  static final ThemeStore _instance = ThemeStore._internal();
  ThemeStore._internal();
  static const String keyTheme = "THEME_MODE";

  factory ThemeStore() {
    return _instance;
  }

 Future<SharedPreferences> _initStorage()  {
  return SharedPreferences.getInstance();
  }


  Future<AppThemeMode> getAppTheme() async {
    final prefs = await _initStorage();
    return _checkMode(prefs.getBool(keyTheme) ?? false);
  }

  Future<void> setAppTheme(AppThemeMode appThemeMode) async {
    final prefs = await _initStorage();
    prefs.setBool(keyTheme, _checkModeValue(appThemeMode));
  }

  bool _checkModeValue(AppThemeMode appThemeMode) {
    return appThemeMode == AppThemeMode.dark;
  }

  AppThemeMode _checkMode(bool isDarkMode) {
    return isDarkMode? AppThemeMode.dark : AppThemeMode.light;
  }




}