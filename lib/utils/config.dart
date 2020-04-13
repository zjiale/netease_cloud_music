import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/center_area_model.dart';
import 'package:netease_cloud_music/model/search_type.dart';
import 'package:netease_cloud_music/utils/cache.dart';
import 'package:netease_cloud_music/utils/fluro/src/router.dart';

class Config {
  static Router router;

  Map<String, String> _headerMap;

  static const int SUCCESS_CODE = 200;

  Map<String, String> getHeader() {
    const String TOKEN = 'token';
    if (null == _headerMap) {
      _headerMap = Map();
      _headerMap["Cookie"] = SpUtil.preferences.get(TOKEN);
    }
    return _headerMap;
  }

  prefixImg(String key) {
    return "assets/icon_$key.png";
  }

  String formatArtist(List _list) {
    String artists = '';
    for (var i = 0; i <= _list.length - 1; i++) {
      if (i == _list.length - 1) {
        artists = '$artists${_list[i]}';
      } else {
        artists = '$artists${_list[i]}\/';
      }
    }
    return artists;
  }

  // /// 返回对应的Rect区域...
  // static Rect getRectFromKey(BuildContext currentContext) {
  //   var object = currentContext?.findRenderObject();
  //   var translation = object?.getTransformTo(null)?.getTranslation();
  //   var size = object?.semanticBounds?.size;

  //   if (translation != null && size != null) {
  //     return new Rect.fromLTWH(
  //         translation.x, translation.y, size.width, size.height);
  //   } else {
  //     return null;
  //   }
  // }

  static List<String> title = ['我的', '发现', '云村', '视频'];

  static List<SearchType> searchType = [
    SearchType(name: '综合', type: 1018),
    SearchType(name: '单曲', type: 1),
    SearchType(name: '视频', type: 1014),
    SearchType(name: '歌手', type: 100),
    SearchType(name: '专辑', type: 10),
    SearchType(name: '歌单', type: 1000),
    SearchType(name: '用户', type: 1002),
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
