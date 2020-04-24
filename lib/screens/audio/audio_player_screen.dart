import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/screens/audio/play_button.dart';
import 'package:netease_cloud_music/screens/audio/slider_time.dart';
import 'package:netease_cloud_music/screens/audio/song_comment.dart';
import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/utils/config.dart';

import 'package:netease_cloud_music/store/model/play_song_model.dart';
import 'package:netease_cloud_music/utils/numbers_convert.dart';

@FFRoute(
    name: "neteasecloudmusic://audioplayerscreen",
    routeName: "DailyRecommendScreen",
    pageRouteType: PageRouteType.material,
    description: "播放歌曲页面")
class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen>
    with TickerProviderStateMixin {
  final List<String> _key = [
    "dislike",
    "song_download",
    "bfc",
    "song_comment",
    "song_more"
  ];
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  AnimationController _imgController;
  AnimationController _fadeController;
  Animation<double> _rotateAnimation;
  Animation<double> _fadeAnimation;

  bool isLike = false;
  double value = 0.0;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: duration);
    _imgController =
        AnimationController(vsync: this, duration: Duration(seconds: 25));
    _fadeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // 为controller添加配置，这里为缩放动画配置
    _rotateAnimation =
        Tween<double>(begin: 0.01, end: -0.05).animate(_controller);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    _imgController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _imgController.reset(); //重置起点
        _imgController.forward(); //开启
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _imgController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Widget _funButton(PlaySongModel model) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _key.asMap().entries.map((MapEntry map) {
              return GestureDetector(
                  onTap: () {
                    switch (map.key) {
                      case 0:
                        setState(() {
                          if (isLike) {
                            isLike = false;
                            _key.replaceRange(0, 1, ['dislike']);
                          } else {
                            isLike = true;
                            _key.replaceRange(0, 1, ['liked']);
                          }
                        });
                        break;
                      case 3:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SongComment(
                                      songModel: model,
                                    )));
                        break;
                      default:
                    }
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(80.0),
                    height: ScreenUtil().setWidth(80.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      "${Config().prefixImg(_key[map.key])}",
                    ))),
                    child: map.key == 3 && model.comment != null
                        ? Align(
                            alignment: model.comment.total < 100
                                ? Alignment(0.5, -0.6)
                                : Alignment(1.2, -0.7),
                            child: Text(
                                NumberUtils.formatNum(model.comment.total),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(18.0))),
                          )
                        : Container(),
                  ));
            }).toList()));
  }

  Widget _body(PlaySongModel model) {
    return Column(children: <Widget>[
      Expanded(
          child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_currentIndex == 0) {
                    _fadeController.forward();
                    _currentIndex = 1;
                  } else {
                    _fadeController.reverse();
                    _currentIndex = 0;
                  }
                });
              },
              child: Container(
                  color: Colors.transparent,
                  child: IndexedStack(index: _currentIndex, children: <Widget>[
                    Stack(alignment: Alignment.topCenter, children: <Widget>[
                      Positioned(
                          top: ScreenUtil().setHeight(200.0),
                          child: RotationTransition(
                            turns: _imgController,
                            child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  ClipOval(
                                      child: ExtendedImage.network(
                                          model.curSong.picUrl,
                                          cache: true,
                                          width: ScreenUtil().setWidth(400),
                                          fit: BoxFit.contain)),
                                  Image.asset('assets/bet.png',
                                      width: ScreenUtil().setWidth(500))
                                ]),
                          )),
                      Align(
                        alignment: Alignment(0.25, -1),
                        // left: MediaQuery.of(context).size.width / 2,
                        child: RotationTransition(
                            turns: _rotateAnimation,
                            alignment: Alignment(
                                -1 +
                                    (ScreenUtil().setWidth(45 * 2) /
                                        (ScreenUtil().setWidth(293))),
                                -1 +
                                    (ScreenUtil().setWidth(45 * 2) /
                                        (ScreenUtil().setWidth(504)))),
                            child: Image.asset('assets/bgm.png',
                                height: ScreenUtil().setHeight(280.0))),
                      )
                    ]),
                    FadeTransition(
                        opacity: _fadeAnimation,
                        child:
                            Container(width: 300.0, color: Colors.amberAccent))
                  ])))),
      _funButton(model),
      SliderTime(model),
      PlayButton(model)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Store.connect<PlaySongModel>(builder: (context, model, child) {
      if (model.curState == AudioPlayerState.PLAYING) {
        _imgController.forward();
        _controller.reverse();
      } else {
        _imgController.stop();
        _controller.forward();
      }
      return Stack(alignment: AlignmentDirectional.center, children: <Widget>[
        ExtendedImage.network(
          model.curSong.picUrl,
          cache: true,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          height: double.infinity,
        ),
        BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54)),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(model.curSong.name,
                          style: TextStyle(fontSize: ScreenUtil().setSp(30.0))),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(model.curSong.artists,
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(25.0),
                                    color: Colors.grey)),
                            Icon(Icons.keyboard_arrow_right,
                                size: ScreenUtil().setWidth(35.0),
                                color: Colors.grey)
                          ])
                    ]),
                actions: <Widget>[
                  IconButton(
                      icon:
                          Icon(Icons.share, size: ScreenUtil().setWidth(40.0)),
                      onPressed: () {})
                ]),
            body: _body(model))
      ]);
    });
  }
}
