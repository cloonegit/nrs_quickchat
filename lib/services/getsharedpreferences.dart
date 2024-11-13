import 'package:NRS_Quickchat/global_function/app_debug.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSharedPreferences {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setPlatform(String platform) async {
    try {
      return await _prefs.setString("platform", platform);
    } catch (e) {
      AppDebug().printDebug(msg: 'error set platform $e');
      return false;
    }
  }

  String getPlatform() {
    try {
      return _prefs.getString("platform") ?? "";
    } catch (e) {
      AppDebug().printDebug(msg: 'error getplatform $e');
      return "";
    }
  }

  Future<bool> setLastLoginStatus(bool login) async {
    try {
      return await _prefs.setBool("last_login", login);
    } catch (e) {
      AppDebug().printDebug(msg: 'error loginstatus $e');
      return false;
    }
  }

  bool getLastLoginStatus() {
    try {
      return _prefs.getBool("last_login") ?? false;
    } catch (e) {
      AppDebug().printDebug(msg: 'error loginstatus $e');
      return false;
    }
  }

  Future<bool> setUserInfo({
    String? userID,
    String? userCode,
    String? userName,
    String? userPosition,
    String? userHQStaff,
  }) async {
    try {
      await _prefs.setString("userID", userID ?? "");
      await _prefs.setString("userCode", userCode ?? "");
      await _prefs.setString("userName", userName ?? "");
      await _prefs.setString("userPosition", userPosition ?? "");
      await _prefs.setString("userHQStaff", userHQStaff ?? "");
      return true;
    } catch (e) {
      AppDebug().printDebug(msg: 'error set user $e');
      return false;
    }
  }

  Future<bool> clearUserInfo() async {
    try {
      await _prefs.setString("userID", "");
      await _prefs.setString("userCode", "");
      await _prefs.setString("userName", "");
      await _prefs.setString("userPosition", "");
      await _prefs.setString("userHQStaff", "");
      return true;
    } catch (e) {
      AppDebug().printDebug(msg: 'error clear user $e');
      return false;
    }
  }

  String getUserID() {
    try {
      return _prefs.getString("userID") ?? "";
    } catch (e) {
      AppDebug().printDebug(msg: 'error get userID $e');
      return "";
    }
  }
}
