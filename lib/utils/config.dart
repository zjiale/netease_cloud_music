import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/model/center_area_model.dart';

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

  prefixImg(String key) {
    return "assets/icon_$key.png";
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

  static List rankType = [
    {"title": "云音乐电音榜", "type": 4},
    {"title": "网易原创歌曲榜", "type": 2},
    {"title": "云音乐新歌榜", "type": 0},
    {"title": "云音乐说唱榜", "type": 23},
    {"title": "云音乐飙升榜", "type": 3},
  ];

  static List<CenterAreaModel> centerArea = [
    CenterAreaModel(
        header: Text(''),
        title: Text('我喜欢的音乐',
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().setSp(25.0))),
        icon: Icon(Icons.favorite,
            size: ScreenUtil().setWidth(60.0), color: Colors.redAccent),
        subTitle: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            width: ScreenUtil().setWidth(142.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white54,
            ),
            child: Row(children: <Widget>[
              Icon(Icons.play_arrow,
                  size: ScreenUtil().setSp(25.0), color: Colors.white),
              Text('心动模式',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(23.0), color: Colors.white))
            ]))),
    CenterAreaModel(
        header: Text(''),
        title: Text('私人FM',
            style: TextStyle(
                color: Colors.white, fontSize: ScreenUtil().setSp(25.0))),
        icon: Icon(Icons.radio,
            size: ScreenUtil().setWidth(60.0), color: Colors.white),
        subTitle: Text('听新鲜的',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(23.0), color: Colors.white))),
    CenterAreaModel(
        header: Text('推荐',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(23.0),
                color: Colors.grey,
                fontWeight: FontWeight.bold)),
        title: Text('驾驶模式',
            style: TextStyle(
                color: Colors.black, fontSize: ScreenUtil().setSp(25.0))),
        icon: Icon(Icons.local_taxi,
            size: ScreenUtil().setWidth(60.0), color: Colors.black),
        subTitle: Text('')),
    CenterAreaModel(
        header: Text('推荐',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(23.0),
                color: Colors.grey,
                fontWeight: FontWeight.bold)),
        title: Text('古典专区',
            style: TextStyle(
                color: Colors.black, fontSize: ScreenUtil().setSp(25.0))),
        icon: Icon(Icons.headset,
            size: ScreenUtil().setWidth(60.0), color: Colors.black),
        subTitle: Text('专业古典大全',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(23.0),
                color: Colors.grey,
                fontWeight: FontWeight.bold))),
    CenterAreaModel(
        header: Text('推荐',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(23.0),
                color: Colors.grey,
                fontWeight: FontWeight.bold)),
        title: Text('最嗨电音',
            style: TextStyle(
                color: Colors.black, fontSize: ScreenUtil().setSp(25.0))),
        icon: Icon(Icons.blur_on,
            size: ScreenUtil().setWidth(60.0), color: Colors.black),
        subTitle: Text('专业电音平台',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(23.0),
                color: Colors.grey,
                fontWeight: FontWeight.bold)))
  ];
}
