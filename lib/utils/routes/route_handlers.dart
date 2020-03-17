import 'package:flutter/material.dart';
import 'package:neteast_cloud_music/screens/audio/audio_player_screen.dart';
import 'package:neteast_cloud_music/screens/daily_recommend/daily_recommend_screen.dart';
import 'package:neteast_cloud_music/screens/home/home_screen.dart';
import 'package:neteast_cloud_music/screens/login/login_screen.dart';
import 'package:neteast_cloud_music/screens/playlist/play_list_ground_screen.dart';
import 'package:neteast_cloud_music/screens/playlist/play_list_screen.dart';
import 'package:neteast_cloud_music/screens/playlist/subscriber_screen.dart';
import 'package:neteast_cloud_music/screens/rank/rank_list_screens.dart';
import 'package:neteast_cloud_music/utils/fluro/fluro.dart';
import 'package:neteast_cloud_music/utils/fluro_convert_util.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginScreen();
});

var playListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PlayListGroundScreen();
});

var playListDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  double expandedHeight = double.parse(params["expandedHeight"]?.first);
  int id = int.parse(params["id"]?.first);
  bool official = FluroConvertUtils.string2bool(params["official"]?.first);
  return PlayListScreen(
      expandedHeight: expandedHeight, id: id, official: official);
});

var subscribersHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int id = int.parse(params["id"]?.first);
  return SubscriberScreen(id: id);
});

var dailyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DailyRecommendScreen();
});

var rankHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RankListScreens();
});

var audioHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AudioPlayerScreen();
});
