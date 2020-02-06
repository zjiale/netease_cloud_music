import 'package:flutter/material.dart';

class Config {
  static List<Tab> titleTabs = <Tab>[
    Tab(text: '我的'),
    Tab(text: '发现'),
    Tab(text: '云村'),
    Tab(text: '视频')
  ];

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
}
