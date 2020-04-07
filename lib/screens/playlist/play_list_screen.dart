import 'dart:ui';
import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/music_song_model.dart';
import 'package:netease_cloud_music/model/play_list.detail.dart';
import 'package:netease_cloud_music/model/subscribers_model.dart';
import 'package:netease_cloud_music/screens/audio/mini_player.dart';
import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/store/model/play_song_model.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:netease_cloud_music/widgets/song_list.dart';

class PlayListScreen extends StatefulWidget {
  final double expandedHeight;
  final int id;
  final bool official;

  PlayListScreen(
      {@required this.expandedHeight,
      @required this.id,
      this.official = false});

  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  List _button = Config.button;
  int _code = Config.SUCCESS_CODE;

  AsyncMemoizer _memoizer = AsyncMemoizer();

  Color bgColor;

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
  }

  Future _initDetailPlayList() {
    return _memoizer.runOnce(() async {
      return CommmonService().getDetailPlayList(widget.id).then((res) {
        if (res.statusCode == 200) {
          PlayListDetailModel _bean = PlayListDetailModel.fromJson(res.data);
          if (_bean.code == _code) {
            getColorFromUrl(_bean.playlist.coverImgUrl).then((color) {
              setState(() {
                bgColor = Color.fromRGBO(color[0], color[1], color[2], 1);
              }); // [R,G,B]
            });
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

  @override
  Widget build(BuildContext context) {
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
                default:
                  return null;
              }
            }));
  }
}
