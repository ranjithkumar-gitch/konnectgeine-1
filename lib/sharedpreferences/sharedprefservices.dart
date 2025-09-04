import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static SharedPreferences? prefs;

  static void clearUserFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();

    prefs!.setString('token', "");
  }

  static const _keytoken = 'token';

  static Future init() async => prefs = await SharedPreferences.getInstance();

  static Future settoken(String token) async =>
      await prefs!.setString(_keytoken, token);

  // getters

  static String? gettoken() => prefs!.getString(_keytoken);
}
