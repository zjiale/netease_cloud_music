import 'dart:io';
import 'package:async/async.dart';
import 'package:color_thief_flutter/color_thief_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:netease_cloud_music/model/banner_model.dart';
import 'package:netease_cloud_music/model/newest_album_model.dart';
import 'package:netease_cloud_music/model/rank.dart';
import 'package:netease_cloud_music/model/rank_list_model.dart';
import 'package:netease_cloud_music/model/recommend_list_model.dart';
import 'package:netease_cloud_music/model/recommend_song_list_model.dart';

import 'package:netease_cloud_music/screens/home/title_header.dart';
import 'package:netease_cloud_music/screens/playlist/play_list_ground_screen.dart';

import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/store/model/tag_model.dart';
import 'package:netease_cloud_music/utils/config.dart';

import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/utils/routes/navigator_util.dart';
import 'package:netease_cloud_music/widgets/custom_scroll_physic.dart';

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

  // 歌单推荐controller
  ScrollController _discController = new ScrollController();
  ScrollPhysics _discPhysics;
  // 歌曲推荐controller
  ScrollController _controller = new ScrollController();
  ScrollPhysics _physics;
  // 新碟controller
  ScrollController _newController = new ScrollController();
  ScrollPhysics _newPhysics;
  // 排行榜controller
  ScrollController _rankController = new ScrollController();
  ScrollPhysics _rankPhysics;

  Future _initData;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _initData = _load();
    super.initState();

    _discController.addListener(() {
      if (_discController.position.haveDimensions && _discPhysics == null) {
        setState(() {
          double itemWidth = ScreenUtil().setWidth(200.0) + 10;
          _discPhysics = PagingScrollPhysics(
              itemDimension: itemWidth,
              maxSize: itemWidth * (6 - 1),
              leadingSpacing: 0.0,
              parent: AlwaysScrollableScrollPhysics());
        });
      }
    });

    _controller.addListener(() {
      if (_controller.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension = _controller.position.maxScrollExtent / (3 - 1);
          _physics = PagingScrollPhysics(
              itemDimension: dimension,
              maxSize: _controller.position.maxScrollExtent,
              leadingSpacing: 0.0);
        });
      }
    });

    _newController.addListener(() {
      if (_newController.position.haveDimensions && _newPhysics == null) {
        setState(() {
          var dimension = _newController.position.maxScrollExtent / (2 - 1);
          _newPhysics = PagingScrollPhysics(
              itemDimension: dimension,
              maxSize: _newController.position.maxScrollExtent,
              leadingSpacing: 0.0);
        });
      }
    });

    _rankController.addListener(() {
      if (_rankController.position.haveDimensions && _rankPhysics == null) {
        setState(() {
          var dimension = _rankController.position.maxScrollExtent / (5 - 1);
          _rankPhysics = PagingScrollPhysics(
              itemDimension: dimension,
              maxSize: _rankController.position.maxScrollExtent,
              leadingSpacing: 0.0);
        });
      }
    });
  }

  @override
  void dispose() {
    _discController.dispose();
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
          List recommendSongList = _bean.recommend
            ..shuffle()
            ..removeWhere((song) => song.status == -200 || song.fee == 1)
            ..removeRange(9, _bean.recommend.length);
          String reason = _bean.recommend.first.reason;
          var filter =
              _bean.recommend.takeWhile((item) => item.reason == reason);
          if (filter.length > 6) {
          } else {
            return recommendSongList;
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
    List<Rank> _list = new List();
    for (var i in _rankType) {
      await CommmonService().getRank(i["type"]).then((res) {
        if (res.statusCode == 200) {
          RankListModel _bean = RankListModel.fromJson(res.data);
          if (_bean.code == _code) {
            List<Tracks> tracks = _bean.playlist.tracks.sublist(0, 3);
            getColorFromUrl(tracks.first.al.picUrl).then((color) {
              return Color.fromRGBO(color[0], color[1], color[2], 1);
            }).then((color) {
              Rank _rank = Rank(
                  title: "${i["title"]}",
                  content: _bean.playlist.tracks.sublist(0, 3),
                  bgColor: color);

              _list.add(_rank);
            });
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
    return Store.connect<TagModel>(builder: (context, model, child) {
      return Container(
        height: ScreenUtil().setHeight(150.0),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40.0)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _type.map((item) {
              return Column(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    switch (item["index"]) {
                      case 0:
                        NavigatorUtil.goDailyPage(context);
                        break;
                      case 1:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlayListGroundScreen(tagModel: model)));
                        break;
                      case 2:
                        NavigatorUtil.goRankPage(context);
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
    });
  }

  Widget home(List bannerList, List recommendList, List recommendSongList,
      List albumList, List homeRankList, double ratio) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(
              // horizontal: ScreenUtil().setWidth(40.0),
              vertical: ScreenUtil().setHeight(20.0)),
          children: <Widget>[
            SizedBox(
                height: ScreenUtil().setHeight(60.0) +
                    MediaQuery.of(context).padding.top),
            HomeBanner(bannerList), //banner
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            playType(), // 首页按钮
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            TitleHeader('推荐歌单', '为你精挑细选', 1),
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            HomeRecommend(
              recommendList: recommendList,
              controller: _discController,
              physics: _discPhysics,
            ), // 发现页面推荐歌单
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            TitleHeader('风格推荐', '根据你喜欢的歌曲推荐', 0),
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            HomeMusicList(
                controller: _controller,
                physics: _physics,
                list: recommendSongList,
                ratio: ratio),
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            TitleHeader('${now.month}月${now.day}日', '新碟', 1),
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            HomeMusicList(
                controller: _newController,
                physics: _newPhysics,
                list: albumList,
                ratio: ratio,
                isAlbum: true),
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            TitleHeader('排行榜', '热歌风向标', 1),
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            HomeRank(
                controller: _rankController,
                physics: _rankPhysics,
                list: homeRankList,
                ratio: ratio),
            SizedBox(
                height: ScreenUtil().setHeight(150.0),
                child: Center(
                    child: Text('到底啦~', style: TextStyle(color: Colors.grey)))),
            SizedBox(height: ScreenUtil().setHeight(20.0))
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
