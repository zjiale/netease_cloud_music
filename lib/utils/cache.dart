import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class SpUtil {
  static SharedPreferences preferences;
  static Future<bool> getInstance() async {
    preferences = await SharedPreferences.getInstance();
    return true;
  }

  // 保存缓存信息
  static set2storage(String key, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (data is int) {
      prefs.setInt(key, data);
    } else if (data is double) {
      prefs.setDouble(key, data);
    } else if (data is String) {
      prefs.setString(key, data);
    } else if (data is List<String>) {
      prefs.setStringList(key, data);
    } else if (data is bool) {
      prefs.setBool(key, data);
    } else if (data is Map) {
      prefs.setString(key, convert.jsonEncode(data));
    } else {
      throw new Exception('cannt found data type');
    }
  }
}
