import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:neteast_cloud_music/store/model/play_video_model.dart';
import 'package:neteast_cloud_music/utils/config.dart';
import 'package:neteast_cloud_music/utils/fluro/fluro.dart';
import 'package:neteast_cloud_music/utils/routes/routes.dart';
import 'package:oktoast/oktoast.dart';
import 'package:neteast_cloud_music/store/index.dart' show Store;
import 'package:neteast_cloud_music/screens/home/home_screen.dart';
import 'package:neteast_cloud_music/utils/cache.dart';
import 'dart:io';

Future<void> main() async {
  debugPaintSizeEnabled = false;

  // 初始化SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();

  // 注册 fluro routes
  Router router = Router();
  Routes.configureRoutes(router);
  Config.router = router;

  LogUtil.init(tag: "来自LogUtil", isDebug: true);

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
          onGenerateRoute: Config.router.generator,
          title: '网易云音乐',
          theme: ThemeData(
            primaryColor: Color(0xffff1916),
          ),
          home: Builder(builder: (context) {
            Store.widgetCtx = context;
            return Store.connect<PlayVideoModel>(
                builder: (context, videoModel, child) {
              return HomeScreen(model: videoModel);
            });
          }),
        ),
      ),
    );
  }
}
