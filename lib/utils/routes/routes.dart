import 'package:flutter/material.dart';
import 'package:neteast_cloud_music/utils/fluro/fluro.dart';
import 'package:neteast_cloud_music/utils/routes/route_handlers.dart';

class Routes {
  static String root = "/";
  static String login = "/login";
  static String playList = "/play_list";
  static String playListDetail = "/play_list_detail";
  static String subscribers = "/subscribers";
  static String daily = "/daily";
  static String rank = "/rank";
  static String audio = "/audio";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参
    router.define(root,
        handler: rootHandler, transitionType: TransitionType.native);
    router.define(login,
        handler: loginHandler, transitionType: TransitionType.native);
    router.define(playList,
        handler: playListHandler, transitionType: TransitionType.native);
    router.define(playListDetail,
        handler: playListDetailHandler, transitionType: TransitionType.native);
    router.define(subscribers,
        handler: subscribersHandler, transitionType: TransitionType.native);
    router.define(daily,
        handler: dailyHandler, transitionType: TransitionType.native);
    router.define(rank,
        handler: rankHandler, transitionType: TransitionType.native);
    router.define(audio,
        handler: audioHandler, transitionType: TransitionType.native);
  }
}
