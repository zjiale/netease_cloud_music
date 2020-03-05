import 'dart:io';
import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wangyiyun/model/banner_model.dart';
import 'package:wangyiyun/model/home_rank_model.dart';
import 'package:wangyiyun/model/newest_album_model.dart';
import 'package:wangyiyun/model/rank_list_model.dart';
import 'package:wangyiyun/model/recommend_list_model.dart';
import 'package:wangyiyun/model/recommend_song_list_model.dart';
import 'package:wangyiyun/screens/daily_recommend/daily_recommend_screen.dart';
import 'package:wangyiyun/screens/home/title_header.dart';
import 'package:wangyiyun/screens/playlist/play_list_ground_screen.dart';
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

class _FindState extends State<Find> with AutomaticKeepAliveClientMixin {
  List _type = Config.type;
  List _rankType = Config.rankType;
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

  Future _initData;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _initData = _load();
    super.initState();

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

  Future _initRankList() async {
    List _list = new List();
    for (var i in _rankType) {
      await CommmonService().getRank(i["type"]).then((res) {
        if (res.statusCode == 200) {
          RankListModel _bean = RankListModel.fromJson(res.data);
          if (_bean.code == _code) {
            _bean.playlist.tracks.removeRange(3, _bean.playlist.tracks.length);
            var rank = {
              "title": "${i["title"]}",
              "content": _bean.playlist.tracks
            };
            _list.add(rank);
          }
        }
      });
    }
    return _list;
  }

  _load() {
    return _memoizer.runOnce(() async {
      return Future.wait([
        _initBanner(),
        _initRecommend(),
        _initRecommendSong(),
        _initNewestAlbum(),
        _initRankList()
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
              GestureDetector(
                onTap: () {
                  switch (item["index"]) {
                    case 0:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DailyRecommendScreen()));
                      break;
                    case 1:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayListGroundScreen()));
                      break;
                    default:
                  }
                },
                child: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: Color(0xffff1916),
                    child:
                        Stack(alignment: Alignment.center, children: <Widget>[
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
              ),
              SizedBox(height: 5.0),
              Text(item["text"],
                  style: TextStyle(fontSize: ScreenUtil().setSp(20.0)))
            ]);
          }).toList()),
    );
  }

  Widget home(List bannerList, List recommendList, List recommendSongList,
      List albumList, List homeRankList, double ratio) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
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
            HomeRank(_rankController, _physics, homeRankList, ratio),
            SizedBox(
                height: ScreenUtil().setHeight(150.0),
                child: Center(
                    child: Text('到底啦~', style: TextStyle(color: Colors.grey)))),
            SizedBox(height: ScreenUtil().setHeight(30.0))
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double ratio = ScreenUtil().setWidth(100.0) /
        (MediaQuery.of(context).size.width - 60); // gridview的宽高比

    return FutureBuilder(
      future: _initData,
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
            List homeRankList = snapshot.data[4];
            return home(bannerList, recommendList, recommendSongList, albumList,
                homeRankList, ratio);
          default:
            return null;
        }
      },
    );
  }
}
