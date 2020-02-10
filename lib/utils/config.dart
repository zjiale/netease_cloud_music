import 'package:flutter/material.dart';

class Config {
  String cookie =
      '__remember_me=true; MUSIC_U=abdca9af4324f26ef36310855b23ab2fcd1fcf1d285067808fc4a467c5dc65cbbdd1e76e7cd8459859b37bbcbfa845e87955a739ab43dce1; __csrf=1ac281f1e4ced023ed502cf28906a07e';
  Map<String, String> _headerMap;

  static int SUCCESS_CODE = 200;

  Map<String, String> getHeader() {
    if (null == _headerMap) {
      _headerMap = Map();
      _headerMap["Cookie"] = cookie;
    }
    return _headerMap;
  }

  static List<Tab> titleTabs = <Tab>[
    Tab(text: '我的'),
    Tab(text: '发现'),
    Tab(text: '云村'),
    Tab(text: '视频')
  ];

  static List<String> title = ['我的', '发现', '动态'];

  static List type = [
    {"image": "assets/icon_daily.png", "text": "每日推荐", "index": 0},
    {"image": "assets/icon_playlist.png", "text": "歌单", "index": 1},
    {"image": "assets/icon_rank.png", "text": "排行榜", "index": 2},
    {"image": "assets/icon_radio.png", "text": "电台", "index": 3},
    {"image": "assets/icon_look.png", "text": "直播", "index": 4}
  ];

  static List button = [
    "assets/icon_comment.png",
    "assets/icon_share.png",
    "assets/icon_download.png",
    "assets/icon_multi_select.png"
  ];

  static List centerBtn = [
    {"image": "assets/icon_music.png", "text": "本地音乐"},
    {"image": "assets/icon_late_play.png", "text": "最近播放"},
    {"image": "assets/icon_download_black.png", "text": "下载管理"},
    {"image": "assets/icon_broadcast.png", "text": "我的电台"},
    {"image": "assets/icon_collect.png", "text": "我的收藏"}
  ];
}
