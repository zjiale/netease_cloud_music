import 'dart:ui';
import 'package:async/async.dart';
import 'package:color_thief_flutter/color_thief_flutter.dart';
<<<<<<< HEAD

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:wangyiyun/api/CommonService.dart';
import 'package:wangyiyun/model/play_list.detail.dart';
import 'package:wangyiyun/screens/playlist/play_list_bottom.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/utils/numbers_convert.dart';
import 'package:wangyiyun/widgets/fade_network_image.dart';
import 'package:wangyiyun/widgets/flexible_detail_bar.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';
import 'package:wangyiyun/widgets/sliver_appbar_custom.dart';

class PlayListScreen extends StatefulWidget {
  final double expandedHeight;
  final int pid;
  final bool isOfficial;

  PlayListScreen(this.expandedHeight, this.pid, {this.isOfficial = false});
=======
import 'package:common_utils/common_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:neteast_cloud_music/api/CommonService.dart';
import 'package:neteast_cloud_music/model/music_song_model.dart';
import 'package:neteast_cloud_music/model/play_list.detail.dart';
import 'package:neteast_cloud_music/model/subscribers_model.dart';
import 'package:neteast_cloud_music/screens/audio/mini_player.dart';
import 'package:neteast_cloud_music/store/index.dart';
import 'package:neteast_cloud_music/store/model/play_song_model.dart';
import 'package:neteast_cloud_music/utils/config.dart';
import 'package:neteast_cloud_music/widgets/song_list.dart';

class PlayListScreen extends StatefulWidget {
  final double expandedHeight;
  final int id;
  final bool official;

  PlayListScreen(
      {@required this.expandedHeight,
      @required this.id,
      this.official = false});
>>>>>>> new

  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  List _button = Config.button;
  int _code = Config.SUCCESS_CODE;

<<<<<<< HEAD
  bool _marquee = false;

  ScrollController _controller = new ScrollController();

=======
>>>>>>> new
  AsyncMemoizer _memoizer = AsyncMemoizer();

  Color bgColor;

<<<<<<< HEAD
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      double ratio = (window.physicalSize.width / 3) /
          750; // 将px转为dp然后再除以750获取像素比，相关文档看screenutil转换原理
      if (_controller.offset >= 120 * ratio && !_marquee) {
        setState(() {
          _marquee = true;
        });
      } else if (_controller.offset < 120 * ratio && _marquee) {
        setState(() {
          _marquee = false;
        });
      }
    });
=======
  String _formateArtist(List<Ar> _list) {
    String artists = '';
    for (var i = 0; i <= _list.length - 1; i++) {
      if (i == _list.length - 1) {
        artists = '$artists${_list[i].name}';
      } else {
        artists = '$artists${_list[i].name}\/';
      }
    }
    return artists;
>>>>>>> new
  }

  Future _initDetailPlayList() {
    return _memoizer.runOnce(() async {
<<<<<<< HEAD
      return CommmonService().getDetailPlayList(widget.pid).then((res) {
        if (res.statusCode == 200) {
          PlayListDetailModel _bean = PlayListDetailModel.fromJson(res.data);
          if (_bean.code == _code) {
=======
      return CommmonService().getDetailPlayList(widget.id).then((res) {
        if (res.statusCode == 200) {
          PlayListDetailModel _bean = PlayListDetailModel.fromJson(res.data);
          if (_bean.code == _code) {
            getColorFromUrl(_bean.playlist.coverImgUrl).then((color) {
              setState(() {
                bgColor = Color.fromRGBO(color[0], color[1], color[2], 1);
              }); // [R,G,B]
            });
>>>>>>> new
            return _bean;
          }
        }
      });
    });
  }

  Widget playButton(int shareCount, int commentCount) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _button.asMap().entries.map((MapEntry map) {
          String _text;
          switch (map.key) {
            case 0:
              _text = commentCount != 0 ? '$commentCount' : '评论';
              break;
            case 1:
              _text = shareCount != 0 ? '$shareCount' : '分享';
              break;
            case 2:
              _text = '下载';
              break;
            case 3:
              _text = '多选';
              break;
          }
          return InkWell(
            onTap: () {
              print(map.key);
            },
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Image.asset(_button[map.key],
                  width: ScreenUtil().setWidth(40.0),
                  height: ScreenUtil().setWidth(40.0)),
              SizedBox(height: ScreenUtil().setHeight(5.0)),
              Text(_text)
            ]),
          );
        }).toList());
  }

<<<<<<< HEAD
  Widget content(PlayListDetailModel detail) {
    return CustomScrollView(controller: _controller, slivers: <Widget>[
      SliverAppBarCustom(
          expandedHeight: widget.expandedHeight,
          title: _marquee
              ? Container(
                  height: ScreenUtil().setHeight(80),
                  child: MarqueeWidget(
                    text: detail.playlist.name,
                    scrollAxis: Axis.horizontal,
                  ),
                )
              : Text('歌单'),
          content: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(35),
                right: ScreenUtil().setWidth(35),
                top: ScreenUtil().setWidth(120),
              ),
              child: Column(children: <Widget>[
                !widget.isOfficial
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            PlayListCoverWidget(detail.playlist.coverImgUrl,
                                width: 230,
                                playCount: NumberUtils.amountConversion(
                                    detail.playlist.playCount)),
                            SizedBox(width: ScreenUtil().setWidth(40.0)),
                            Expanded(
                                child: Container(
                              height: ScreenUtil().setWidth(230),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(detail.playlist.name,
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(33.0),
                                            fontWeight: FontWeight.bold)),
                                    Row(children: <Widget>[
                                      ClipOval(
                                          child: Container(
                                        width: 20.0,
                                        height: 20.0,
                                        child: ExtendedImage.network(
                                            detail.playlist.creator.avatarUrl,
                                            fit: BoxFit.cover),
                                      )),
                                      SizedBox(
                                          width: ScreenUtil().setWidth(10.0)),
                                      Text(detail.playlist.creator.nickname,
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenUtil().setSp(25.0),
                                              color: Color(0xffcdcdcd))),
                                      Icon(Icons.keyboard_arrow_right,
                                          size: ScreenUtil().setSp(40.0),
                                          color: Color(0xffcdcdcd))
                                    ]),
                                    Text(detail.playlist.description,
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(20.0),
                                            color: Color(0xffcdcdcd)),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis)
                                  ]),
                            ))
                          ])
                    : Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              right: ScreenUtil().setWidth(40.0)),
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(detail.playlist.name,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(33.0),
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  height: ScreenUtil().setHeight(30.0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(5.0),
                                      vertical: ScreenUtil().setHeight(3.0)),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(2.0),
                                      color: Colors.white.withOpacity(0.3)),
                                  child: Text(
                                    '每日更新',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(18.0),
                                        color: Colors.grey),
                                  ),
                                ),
                                Text(detail.playlist.description,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(20.0),
                                        color: Color(0xffcdcdcd)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis)
                              ]),
                        ),
                      ),
                SizedBox(height: ScreenUtil().setHeight(30.0)),
                playButton(
                    detail.playlist.shareCount, detail.playlist.commentCount)
              ]),
            ),
          ),
          background: widget.isOfficial
              ? Container(
                  // width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  child: FadeNetWorkImage(detail.playlist.coverImgUrl))
              : Stack(
                  children: <Widget>[
                    Container(
                        // width: MediaQuery.of(context).size.width,
                        height: double.infinity,
                        child: FadeNetWorkImage(
                            detail.playlist.backgroundCoverUrl)),
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaY: 5,
                        sigmaX: 5,
                      ),
                      child: Container(
                        color: Colors.black26,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ],
                ),
          bottom: PlayListBottom(detail: detail)),
      SliverPadding(
        padding: EdgeInsets.only(left: 10.0),
        sliver: SliverFixedExtentList(
          itemExtent: ScreenUtil().setHeight(100.0),
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(60.0),
                    child: Center(
                      child: Text('${index + 1}',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(30.0),
                              color: Colors.black45)),
                    ),
                  ),
                  Expanded(
                      child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    title: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: detail.playlist.tracks[index].name,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(28.0),
                                color: detail.privileges[index].st == -200
                                    ? Colors.grey
                                    : Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: detail.playlist.tracks[index].tns !=
                                          null
                                      ? '(${detail.playlist.tracks[index].tns.first})'
                                      : '',
                                  style: TextStyle(color: Color(0xffcdcdcd)))
                            ])),
                    subtitle: Text(
                        '${detail.playlist.tracks[index].ar.first.name} - ${detail.playlist.tracks[index].al.name}',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(20.0),
                            color: detail.privileges[index].st == -200
                                ? Colors.grey
                                : Colors.black54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  )),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  )
                ]);
          }, childCount: detail.playlist.trackCount),
        ),
      ),
      SliverToBoxAdapter(
          child: Container(height: ScreenUtil().setHeight(100.0))),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

=======
  @override
  Widget build(BuildContext context) {
>>>>>>> new
    return Scaffold(
        body: FutureBuilder(
            future: _initDetailPlayList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                      child: SpinKitChasingDots(
                          color: Theme.of(context).primaryColor, size: 30.0));
                case ConnectionState.done:
<<<<<<< HEAD
                  PlayListDetailModel playList = snapshot.data;
                  return content(playList);
=======
                  List<MusicSong> _list = [];
                  List<SubscribersModel> _suscribers = [];
                  PlayListDetailModel playList = snapshot.data;
                  playList.playlist.tracks.forEach((song) {
                    _list.add(MusicSong(
                        id: song.id,
                        mvid: song.mv,
                        totalTime: song.dt,
                        name: song.name,
                        subName: song.alia.length > 0 ? song.alia.first : '',
                        artists: song.ar.length == 1
                            ? song.ar.first.name
                            : _formateArtist(song.ar),
                        album: song.al.name,
                        st: song.st,
                        isVip: song.fee == 1 ? true : false));
                  });
                  playList.playlist.subscribers.forEach((subscriber) {
                    _suscribers.add(SubscribersModel(
                        name: subscriber.nickname,
                        id: subscriber.userId,
                        description: subscriber.description,
                        avatarUrl: subscriber.avatarUrl,
                        gender: subscriber.gender));
                  });
                  return Stack(
                    children: <Widget>[
                      SongList(
                        expandedHeight: widget.expandedHeight,
                        id: widget.id,
                        detail: playList,
                        list: _list,
                        suscribers: _suscribers,
                        bgColor: bgColor,
                        playlistbutton: playButton(playList.playlist.shareCount,
                            playList.playlist.commentCount),
                        official: widget.official,
                      ),
                      Positioned(
                          bottom: 0.0,
                          child: Store.connect<PlaySongModel>(
                              builder: (context, model, child) {
                            return Offstage(
                                offstage: model.show,
                                child: MiniPlayer(model: model));
                          }))
                    ],
                  );
>>>>>>> new
                default:
                  return null;
              }
            }));
  }
}
