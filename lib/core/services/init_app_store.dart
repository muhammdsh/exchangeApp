import 'package:shared_preferences/shared_preferences.dart';

class InitAppStore {

  static final InitAppStore _instance = InitAppStore._internal();
  InitAppStore._internal();

  static const String firstTimeKey = "IS_FIRST_TIME";

  factory InitAppStore() {
    return _instance;
  }

  Future<SharedPreferences> _initStorage()  {
    return SharedPreferences.getInstance();
  }

  Future<void> setFirstTime() async {
    final prefs = await _initStorage();
    prefs.setBool(firstTimeKey, false);
    return;
  }

  Future<bool> get isFirstTime async {
    final prefs = await _initStorage();
    bool data = true;
    if(prefs.containsKey(firstTimeKey)) {
       data = prefs.getBool(firstTimeKey);
    }
    return data;
  }



}