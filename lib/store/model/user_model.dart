import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/api/api.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/utils/cache.dart';
import 'package:oktoast/oktoast.dart';

class UserModel with ChangeNotifier {
  static const String USER_KEY = 'user';
  static const String TOKEN = 'token';
  User _user;

  User get user => _user;

  void init() {
    if (SpUtil.preferences.containsKey(USER_KEY)) {
      String userInfo = SpUtil.preferences.get(USER_KEY);
      _user = User.fromJson(json.decode(userInfo));
    }
  }

  void setUser(User userInfo) {
    User user = userInfo;
    _user = user;
  }

  Future<User> login(int phone, String password) async {
    Response response =
        await Dio().get("${Api.LOGIN}?phone=$phone&password=$password");
    User user = User.fromJson(response.data);
    if (user.code > 299) {
      showToast(
        '登录失败，请检查账号和密码!!!',
        position: ToastPosition.bottom,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.grey,
        radius: 13.0,
        textStyle: TextStyle(fontSize: 15.0),
      );
      return null;
    }
    showToast(
      '登录成功!!!',
      position: ToastPosition.bottom,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.grey,
      radius: 13.0,
      textStyle: TextStyle(fontSize: 15.0),
    );
    _save2sp(user);
    return user;
  }

  void _save2sp(User user) {
    SpUtil.preferences
        .setString(TOKEN, '__remember_me=true; MUSIC_U=${user.token}');
    SpUtil.preferences.setString(USER_KEY, user.toString());
  }
}
