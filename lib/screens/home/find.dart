import 'dart:io';
import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wangyiyun/model/banner_model.dart';
import 'package:wangyiyun/model/newest_album_model.dart';
import 'package:wangyiyun/model/recommend_list_model.dart';
import 'package:wangyiyun/model/recommend_song_list_model.dart';
import 'package:wangyiyun/screens/home/title_header.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/utils/custom_scroll_physic.dart';
import 'package:wangyiyun/api/CommonService.dart';

import 'home_banner.dart';
import 'home_rank.dart';
import 'home_recommend.dart';
import 'home_music_list.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  List _type = Config.type;
  int _code = Config.SUCCESS_CODE;

  DateTime now = new DateTime.now();
  AsyncMemoizer _memoizer = AsyncMemoizer();

  // 推荐controller
  ScrollController _controller = new ScrollController();
  // 新碟controller
  ScrollController _newController = new ScrollController();
  // 排行榜controller
  ScrollController _rankController = new ScrollController();

  ScrollPhysics _physics;

  @override
  void initState() {
    super.initState();
    _initBanner();
    _initRecommend();
    _initRecommendSong();
    _initNewestAlbum();

    _controller.addListener(() {
      if (_controller.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension = _controller.position.maxScrollExtent / 2;
          _physics = CustomScrollPhysics(itemDimension: dimension);
        });
      }
    });

    _newController.addListener(() {
      if (_newController.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension = _newController.position.maxScrollExtent;
          _physics = CustomScrollPhysics(itemDimension: dimension);
        });
      }
    });

    _rankController.addListener(() {
      if (_rankController.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension = _rankController.position.maxScrollExtent / 4;
          _physics = CustomScrollPhysics(itemDimension: dimension);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _newController.dispose();
    _rankController.dispose();
    super.dispose();
  }

  Future _initBanner() {
    int _type;
    if (Platform.isAndroid) {
      _type = 1;
    } else if (Platform.isIOS) {
      _type = 2;
    }
    return CommmonService().getBanner(_type).then((res) {
      if (res.statusCode == 200) {
        BannersModel _bean = BannersModel.fromJson(res.data);
        if (_bean.code == _code) {
          return _bean.banners;
          // setState(() {
          //   _bannerList = banners;
          // });
        }
      }
    });
  }

  Future _initRecommend() {
    return CommmonService().getRecommendList().then((res) {
      if (res.statusCode == 200) {
        RecommendListModel _bean = RecommendListModel.fromJson(res.data);
        if (_bean.code == _code) {
          return _bean.recommend;
          // setState(() {
          //   _recommendList = recommendList;
          // });
        }
      }
    });
  }

  Future _initRecommendSong() {
    return CommmonService().getRecommendSongList().then((res) {
      if (res.statusCode == 200) {
        RecommendSongListModel _bean =
            RecommendSongListModel.fromJson(res.data);
        if (_bean.code == _code) {
          _bean.recommend
            ..shuffle()
            ..removeRange(9, _bean.recommend.length);
          List recommendSongList = _bean.recommend;
          String reason = _bean.recommend.first.reason;
          var filter =
              _bean.recommend.takeWhile((item) => item.reason == reason);
          if (filter.length > 6) {
          } else {
            return recommendSongList;
            // setState(() {
            //   _recommendSongList = recommendSongList;
            // });
          }
        }
      }
    });
  }

  Future _initNewestAlbum() {
    return CommmonService().getNewestAlbum().then((res) {
      if (res.statusCode == 200) {
        NewestAlbumModel _bean = NewestAlbumModel.fromJson(res.data);
        if (_bean.code == _code) {
          _bean.albums
            ..shuffle()
            ..removeRange(6, _bean.albums.length);
          return _bean.albums;
        }
      }
    });
  }

  Future _initNewestAlbum() {
    return CommmonService().getNewestAlbum().then((res) {
      if (res.statusCode == 200) {
        NewestAlbumModel _bean = NewestAlbumModel.fromJson(res.data);
        if (_bean.code == _code) {
          _bean.albums
            ..shuffle()
            ..removeRange(6, _bean.albums.length);
          return _bean.albums;
        }
      }
    });
  }

  _load() {
    return _memoizer.runOnce(() async {
      return Future.wait([
        _initBanner(),
        _initRecommend(),
        _initRecommendSong(),
        _initNewestAlbum()
      ]);
    });
  }

  Widget playType() {
    return Container(
      height: ScreenUtil().setHeight(150.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _type.map((item) {
            return Column(children: <Widget>[
              CircleAvatar(
                  radius: 22.0,
                  backgroundColor: Color(0xffff1916),
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Image.asset(item["image"]),
                    item["index"] == 0
                        ? Align(
                            alignment: FractionalOffset(0.5, 0.55),
                            child: Text(
                              '${now.day}',
                              style: TextStyle(
                                  color: Color(0xffff1916),
                                  fontSize: ScreenUtil().setSp(25.0),
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container()
                  ])),
              SizedBox(height: 5.0),
              Text(item["text"],
                  style: TextStyle(fontSize: ScreenUtil().setSp(20.0)))
            ]);
          }).toList()),
    );
  }

  Widget home(List bannerList, List recommendList, List recommendSongList,
      List albumList, double ratio) {
    return ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(80.0)),
          HomeBanner(bannerList), //banner
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          playType(), // 首页按钮
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          TitleHeader('推荐歌单', '为你精挑细选', 1),
          HomeRecommend(recommendList), // 发现页面推荐歌单
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          TitleHeader('风格推荐', '根据你喜欢的歌曲推荐', 0),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          HomeMusicList(_controller, _physics, recommendSongList, ratio),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          TitleHeader('${now.month}月${now.day}日', '新碟', 1),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          HomeMusicList(_newController, _physics, albumList, ratio,
              isAlbum: true),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          TitleHeader('排行榜', '热歌风向标', 1),
          SizedBox(height: ScreenUtil().setHeight(20.0)),
          // HomeRank(_rankController, _physics, albumList, ratio),
          SizedBox(
              height: ScreenUtil().setHeight(150.0),
              child: Center(
                  child: Text('到底啦~', style: TextStyle(color: Colors.grey))))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    double ratio = ScreenUtil().setWidth(100.0) /
        (MediaQuery.of(context).size.width - 60); // gridview的宽高比

    return FutureBuilder(
      future: _load(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
                child: SpinKitChasingDots(
                    color: Theme.of(context).primaryColor, size: 30.0));
          case ConnectionState.done:
            List bannerList = snapshot.data[0];
            List recommendList = snapshot.data[1];
            List recommendSongList = snapshot.data[2];
            List albumList = snapshot.data[3];
            return home(
                bannerList, recommendList, recommendSongList, albumList, ratio);
          default:
            return null;
        }
      },
    );
  }
}
