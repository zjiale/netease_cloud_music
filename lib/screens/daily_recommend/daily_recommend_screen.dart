import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wangyiyun/api/CommonService.dart';
import 'package:wangyiyun/model/music_song_model.dart';
import 'package:wangyiyun/model/recommend_song_list_model.dart';
import 'package:wangyiyun/screens/playlist/play_list_bottom.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/widgets/sliver_appbar_custom.dart';
import 'package:wangyiyun/widgets/song_item.dart';
import 'package:wangyiyun/widgets/space_bar.dart';

class DailyRecommendScreen extends StatefulWidget {
  @override
  _DailyRecommendScreenState createState() => _DailyRecommendScreenState();
}

class _DailyRecommendScreenState extends State<DailyRecommendScreen> {
  DateTime _now = new DateTime.now();
  ScrollController _controller = new ScrollController();
  String _title = '';

  int _code = Config.SUCCESS_CODE;

  Future _initData;

  @override
  void initState() {
    super.initState();

    _initData = _initDailyRecommend();

    double ratio = (window.physicalSize.width / window.devicePixelRatio) /
        750; // 将px转为dp然后再除以750获取像素比，相关文档看screenutil转换原理
    double ratio1 =
        (window.physicalSize.height / window.devicePixelRatio) / 1334;
    double _scrollOffset = (350 * ratio1) - (100 * ratio) - kToolbarHeight;
    _controller.addListener(() {
      // _opacity =
      //     _opacity < 0 ? 0 : 1.0 - max(0.0, _controller.offset) / _scrollOffset;
      if (_controller.offset >= _scrollOffset && _title == '') {
        setState(() {
          _title = '每日推荐';
        });
      } else if (_controller.offset < _scrollOffset && _title != '') {
        setState(() {
          _title = '';
        });
      }
    });
  }

  Future _initDailyRecommend() {
    return CommmonService().getRecommendSongList().then((res) {
      if (res.statusCode == 200) {
        RecommendSongListModel _bean =
            RecommendSongListModel.fromJson(res.data);
        if (_bean.code == _code) {
          return _bean.recommend;
        }
      }
    });
  }

  String _formateArtist(List<Artists> _list) {
    String artists = '';
    for (var i = 0; i <= _list.length - 1; i++) {
      if (i == _list.length - 1) {
        artists = '$artists${_list[i].name}';
      } else {
        artists = '$artists${_list[i].name}\/';
      }
    }
    return artists;
    // _list.forEach((artist){
    //   artists+='${artist.name}\/';
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _initData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: SpinKitChasingDots(
                        color: Theme.of(context).primaryColor, size: 30.0));
              case ConnectionState.done:
                List<Recommend> recommendList = snapshot.data;
                List<MusicSong> _list = [];
                recommendList.forEach((song) {
                  _list.add(MusicSong(song.id,
                      mvid: song.mvid,
                      totalTime: song.duration,
                      name: song.name,
                      subName: song.transName != null
                          ? song.transName
                          : song.alias.length > 0 ? song.alias.first : '',
                      artists: song.artists.length == 1
                          ? song.artists.first.name
                          : _formateArtist(song.artists),
                      album: song.album.name,
                      picUrl: song.album.picUrl,
                      st: song.privilege.st,
                      isHighQuality:
                          song.privilege.maxbr == 999000 ? true : false,
                      isVip: song.fee == 1 ? true : false));
                });
                return CustomScrollView(
                  controller: _controller,
                  slivers: <Widget>[
                    SliverAppBarCustom(
                        expandedHeight: 350,
                        title: Text(_title,
                            style:
                                TextStyle(fontSize: ScreenUtil().setSp(32.0))),
                        content: SafeArea(
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(35),
                                  top: ScreenUtil().setWidth(120),
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      RichText(
                                          text: TextSpan(
                                              text: _now.day < 10
                                                  ? '0${_now.day}'
                                                  : _now.day,
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(70.0),
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white),
                                              children: <TextSpan>[
                                            TextSpan(
                                              text: '\/',
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(40.0),
                                                  color: Colors.white),
                                            ),
                                            TextSpan(
                                              text: _now.month < 10
                                                  ? '0${_now.month}'
                                                  : _now.month,
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(40.0),
                                                  color: Colors.white),
                                            ),
                                          ])),
                                      SizedBox(
                                          height: ScreenUtil().setHeight(30.0)),
                                    ]))),
                        background: Image.asset('assets/bg_daily.png',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            colorBlendMode: BlendMode.srcOver,
                            color: Colors.white.withOpacity(0.2)),
                        bottom: PlayListBottom(
                          show: false,
                        )),
                    SliverPadding(
                      padding: EdgeInsets.only(left: 10.0),
                      sliver: SliverFixedExtentList(
                        itemExtent: ScreenUtil().setHeight(100.0),
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return SongItem(
                            index: index,
                            showIndex: true,
                            detail: _list[index],
                          );
                        }, childCount: recommendList.length),
                      ),
                    ),
                  ],
                );
              default:
                return null;
            }
          }),
    );
  }
}
