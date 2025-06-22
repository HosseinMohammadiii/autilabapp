import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveUserToken(String token) async {
    return await _prefs!.setString('Authorization', token);
  }

  static Future<bool> userLogIn() async {
    return await _prefs!.setBool('isLogIn', false);
  }

  static Future<String?> getUserToken() async {
    return _prefs?.getString('Authorization');
  }

  static Future<bool> isUserLogIn() async {
    return _prefs?.getBool('isLogIn') ?? false;
  }
}
