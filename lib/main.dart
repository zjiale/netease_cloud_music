import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netease_cloud_music/netease_cloud_music_route_helper.dart';
import 'package:netease_cloud_music/screens/no_route.dart';
import 'package:netease_cloud_music/screens/splash_screen.dart';
import 'package:netease_cloud_music/store/model/play_video_model.dart';
import 'package:netease_cloud_music/store/model/user_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:netease_cloud_music/store/index.dart' show Store;
import 'package:netease_cloud_music/utils/cache.dart';

Future<void> main() async {
  debugPaintSizeEnabled = false;
  debugPaintLayerBordersEnabled = false;
  debugRepaintRainbowEnabled = false;
  debugProfilePaintsEnabled = false;

  // 初始化SharedPreferences
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
          title: '网易云音乐',
          theme: ThemeData(
            primaryColor: Color(0xffff1916),
          ),
          showPerformanceOverlay: false,
          checkerboardOffscreenLayers:
              false, // 使用了saveLayer的图形会显示为棋盘格式并随着页面刷新而闪烁
          checkerboardRasterCacheImages:
              false, // 做了缓存的静态图片在刷新页面时不会改变棋盘格的颜色；如果棋盘格颜色变了说明被重新缓存了，这是我们要避免的

          navigatorObservers: [
            FFNavigatorObserver(routeChange: (
              Route newRoute,
              Route oldRoute,
            ) {
              FFRouteSettings newSetting;
              FFRouteSettings oldSetting;

              if (newRoute?.settings is FFRouteSettings) {
                newSetting = newRoute.settings;
              }
              if (oldRoute?.settings is FFRouteSettings) {
                oldSetting = oldRoute.settings;
              }

              if (newRoute is PageRoute &&
                  (
                      //first page
                      oldRoute == null ||
                          //exclude PopupRoute ect
                          oldRoute is PageRoute) &&
                  newSetting?.routeName != null) {
                // //you can track page here
                // print("route change: ${newSetting?.routeName}");
              }
            })
          ],
          // initialRoute: Routes
          //     .NETEASECLOUDMUSIC_SPLASHSCREEN, // neteasecloudmusic://splashscreen
          onGenerateRoute: (RouteSettings settings) =>
              onGenerateRouteHelper(settings, notFoundFallback: NoRoute()),
          home: Builder(builder: (context) {
            Store.widgetCtx = context;
            return Store.connect2<PlayVideoModel, UserModel>(
                builder: (context, videoModel, userModel, child) {
              return SplashScreen(videoModel: videoModel, userModel: userModel);
            });
          }),
        ),
      ),
    );
  }
}
