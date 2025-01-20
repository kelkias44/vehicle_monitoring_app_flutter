import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? instance;
  static SharedPreferences? preferences;

  static Future<LocalStorageService> getInstance() async {
    instance ??= LocalStorageService();
    preferences ??= await SharedPreferences.getInstance();
    
    return instance!;
  }

  saveStringToDisk(String key, String content) {
    preferences!.setString(key, content);
  }

  saveBooleanToDisk(String key, bool content) async {
    await preferences!.setBool(key, content);
  }

  Future<bool> isLogin(String key) async {
    var value = preferences!.getBool(key);
    return value ?? false;
  }

  Future<String?> getStringFromDisk(String key) async {
    var value = preferences!.getString(key);
    return value;
  }
}