import 'package:flutter/material.dart';
import 'package:neteast_cloud_music/utils/config.dart';
import 'package:neteast_cloud_music/utils/fluro/fluro.dart';
import 'package:neteast_cloud_music/utils/routes/routes.dart';

class NavigatorUtil {
  // 跳转到首页
  static void goHomePage(BuildContext context) {
    Config.router.navigateTo(context, Routes.root);
  }

  // 跳转到登录
  static void goLoginPage(BuildContext context) {
    Config.router.navigateTo(context, Routes.login);
  }

  // 跳转到歌单广场
  static void goPlayListPage(BuildContext context) {
    Config.router.navigateTo(context, Routes.playList);
  }

  // 跳转到歌单详情
  static void goPlayListDetailPage(BuildContext context,
      {@required double expandedHeight,
      @required int id,
      bool official = false}) {
    Config.router.navigateTo(
        context,
        Routes.playListDetail +
            "?expandedHeight=$expandedHeight&id=$id&official=$official");
  }

  // 跳转到收藏者
  static void goSubscribersPage(BuildContext context, {@required int id}) {
    Config.router.navigateTo(context, Routes.subscribers + "?id=$id");
  }

  // 跳转到每日推荐
  static void goDailyPage(BuildContext context) {
    Config.router.navigateTo(context, Routes.daily);
  }

  // 跳转到排行榜
  static void goRankPage(BuildContext context) {
    Config.router.navigateTo(context, Routes.rank);
  }

  // 跳转到播放器
  static void goAudioPage(BuildContext context) {
    Config.router.navigateTo(context, Routes.audio);
  }
}
