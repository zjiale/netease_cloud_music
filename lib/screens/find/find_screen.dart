import 'package:async/async.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:netease_cloud_music/netease_cloud_music_route.dart';
import 'package:netease_cloud_music/screens/home/title_header.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/widgets/custom_scroll_physic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home_banner.dart';
import 'home_rank.dart';
import 'home_recommend.dart';
import 'home_music_list.dart';

class FindScreen extends StatefulWidget {
  @override
  _FindScreenState createState() => _FindScreenState();
}

class _FindScreenState extends State<FindScreen>
    with AutomaticKeepAliveClientMixin {
  List _type = Config.type;

  CommmonService api = CommmonService();

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
    _initData = _load(); //防止页面重绘
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

  Future<List> _getRankList() async {
    List _rankList = [];
    List _rankType = Config.rankType;
    for (var item in _rankType) {
      _rankList.add(await api.getRank(item));
    }
    return _rankList;
  }

  _load() {
    return _memoizer.runOnce(() async {
      return Future.wait([
        api.getBanner(),
        api.getRecommendList(),
        api.getRecommendSongList(),
        api.getNewestAlbum(),
        _getRankList(),
        api.getPlayLitsTags(),
      ]);
    });
  }

  Widget _playType(List tags) {
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
                      Navigator.pushNamed(context,
                          Routes.NETEASECLOUDMUSIC_DAILYRECOMMENDSCREEN);
                      break;
                    case 1:
                      Navigator.pushNamed(context,
                          Routes.NETEASECLOUDMUSIC_PLAYLISTGROUNDSCREEN,
                          arguments: {"tagList": tags});
                      break;
                    case 2:
                      Navigator.pushNamed(
                          context, Routes.NETEASECLOUDMUSIC_RANKLISTSCREEN);
                      break;
                    default:
                  }
                },
                child: CircleAvatar(
                    radius: 22.0,
                    backgroundColor: Color(0xffff1916),
                    child:
                        Stack(alignment: Alignment.center, children: <Widget>[
                      ExtendedImage.asset(
                        item["image"],
                        enableMemoryCache: true,
                      ),
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

  Widget _home(List bannerList, List recommendList, List recommendSongList,
      List albumList, List homeRankList, List tagList, double ratio) {
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
            _playType(tagList), // 首页按钮
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
                list: recommendSongList,
                controller: _controller,
                physics: _physics,
                ratio: ratio),
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            TitleHeader('${now.month}月${now.day}日', '新碟', 1),
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            HomeMusicList(
                list: albumList,
                controller: _newController,
                physics: _newPhysics,
                ratio: ratio,
                isAlbum: true),
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            TitleHeader('排行榜', '热歌风向标', 1),
            SizedBox(height: ScreenUtil().setHeight(20.0)),
            HomeRank(
                list: homeRankList,
                controller: _rankController,
                physics: _rankPhysics,
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
            List tags = snapshot.data[5];

            // return Container();

            return _home(bannerList, recommendList, recommendSongList,
                albumList, homeRankList, tags, ratio);
          default:
            return null;
        }
      },
    );
  }
}
