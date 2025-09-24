import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveUserToken(String token) async {
    return await _prefs!.setString('Authorization', token);
  }

  static Future<bool> userLogIn(bool isLogIn) async {
    return await _prefs!.setBool('isLogIn', isLogIn);
  }

  static Future<bool> isFirstTimeLogIn(bool isLogIn) async {
    return await _prefs!.setBool('firstTimeLogIn', isLogIn);
  }

  static Future<bool> setQurstionId(int id) async {
    return await _prefs!.setInt('questionId', id);
  }

  static Future<String?> getUserToken() async {
    return _prefs?.getString('Authorization');
  }

  static Future<bool> isUserLogIn() async {
    return _prefs?.getBool('isLogIn') ?? false;
  }

  static Future<bool> firstTimeLogIn() async {
    return _prefs?.getBool('firstTimeLogIn') ?? true;
  }

  static Future<int> getQuestionId() async {
    return _prefs?.getInt('questionId') ?? 1;
  }
}
