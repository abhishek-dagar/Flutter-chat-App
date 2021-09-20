import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String phoneNumberKey = "PHONENUMBERKEY";

  // save data
  static Future<bool> saveUserName(String getuserName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userNameKey, getuserName);
  }

  static Future<bool> saveUserId(String getuserIdKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userIdKey, getuserIdKey);
  }

  static Future<bool> saveUserPhonenumber(String getphoneNumberKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(phoneNumberKey, getphoneNumberKey);
  }

  //get data
  static Future<String> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }

  static Future<String> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userIdKey);
  }

  static Future<String> getUserPhonenumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(phoneNumberKey);
  }
}
