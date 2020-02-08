import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wangyiyun/screens/home/home_screen.dart';
import 'package:wangyiyun/screens/login/login_screen.dart';
import 'package:wangyiyun/screens/playlist/play_list_screen.dart';
import 'package:wangyiyun/screens/user_center/user_center_screen.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '网易云音乐',
      theme: ThemeData(
        primaryColor: Color(0xffff1916),
      ),
      home: HomeScreen(),
    );
  }
}
