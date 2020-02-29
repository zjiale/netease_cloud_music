import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wangyiyun/store/index.dart' show Store;
import 'package:wangyiyun/screens/home/home_screen.dart';
import 'package:wangyiyun/utils/cache.dart';

Future<void> main() async {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Store.init(
      context: context,
      child: OKToast(
        child: MaterialApp(
          showPerformanceOverlay: false,
          title: '网易云音乐',
          theme: ThemeData(
            primaryColor: Color(0xffff1916),
          ),
          home: Builder(builder: (context) {
            Store.widgetCtx = context;
            return HomeScreen();
          }),
        ),
      ),
    );
  }
}
