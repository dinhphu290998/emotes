import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _preferences;

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //Int
  static setIntValue(int value, String key) {
    _preferences?.setInt(key, value);
  }

  static int? getIntValue(String key) =>
      _preferences?.getInt(key);

  //String
  static setStringValue(String value, String key) {
    _preferences?.setString(key, value);
  }

  static String? getStringValue(String key) =>
      _preferences?.getString(key);

  //Bool
  static setBoolValue(bool value, String key) {
    _preferences?.setBool(key, value);
  }

  static bool? getBoolValue(String key) =>
      _preferences!.getBool(key);

  //Remove
  static removeValue(String key) {
    _preferences?.remove(key);
  }
}