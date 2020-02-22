import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/screens/audio/play_button.dart';
import 'package:wangyiyun/store/index.dart';
import 'package:wangyiyun/utils/config.dart';

import 'package:wangyiyun/store/model/play_song_model.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen>
    with TickerProviderStateMixin {
  final List<String> _key = [
    "dislike",
    "song_download",
    "song_comment",
    "song_more"
  ];
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  AnimationController _imgController;
  Animation<double> _rotateAnimation;

  bool isLike = false;
  double value = 0.0;

  int mode = 0; //模拟数据

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: duration);
    _imgController =
        AnimationController(vsync: this, duration: Duration(seconds: 25));
    // 为controller添加配置，这里为缩放动画配置
    _rotateAnimation =
        Tween<double>(begin: 0.01, end: -0.05).animate(_controller);
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
    super.dispose();
  }

  Widget _funButton(PlaySongModel model) {
    return Positioned(
        bottom: 110.0,
        child: Container(
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
                        default:
                      }
                    },
                    child: Stack(overflow: Overflow.visible, children: <Widget>[
                      Image.asset("${Config().prefixImg(_key[map.key])}",
                          width: ScreenUtil().setWidth(80.0)),
                      map.key == 2
                          ? Positioned(
                              right: -6.0,
                              top: 5.0,
                              child: Text('999+',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(18.0))),
                            )
                          : Container()
                    ]),
                  );
                }).toList())));
  }

  Widget _playTime(PlaySongModel model) {
    return Positioned(
        bottom: 80.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('00:00',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(20.0),
                        color: Colors.white)),
                SizedBox(width: ScreenUtil().setWidth(5.0)),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white54, //进度条滑块左边颜色
                        inactiveTrackColor: Colors.grey, //进度条滑块右边颜色
                        thumbColor: Colors.white, //滑块颜色
                        overlayColor: Colors.white, //滑块拖拽时外圈的颜色
                        overlayShape: RoundSliderOverlayShape(
                          //可继承SliderComponentShape自定义形状
                          overlayRadius: ScreenUtil().setWidth(15.0), //滑块外圈大小
                        ),
                        thumbShape: RoundSliderThumbShape(
                          //可继承SliderComponentShape自定义形状
                          enabledThumbRadius: ScreenUtil().setWidth(8.0), //滑块大小
                        )),
                    child: Slider(
                      value: value,
                      onChanged: (v) {
                        setState(() => value = v);
                      },
                      max: 100,
                      min: 0,
                    ),
                  ),
                ),
                SizedBox(width: ScreenUtil().setWidth(5.0)),
                Text('04:06',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(20.0), color: Colors.grey))
              ]),
        ));
  }

  Widget _body(PlaySongModel model) {
    return Stack(alignment: Alignment.topCenter, children: <Widget>[
      Positioned(
          top: ScreenUtil().setHeight(200.0),
          child: RotationTransition(
            turns: _imgController,
            child: Stack(alignment: Alignment.center, children: <Widget>[
              ClipOval(
                  child: ExtendedImage.network(model.curSong.picUrl,
                      cache: true,
                      width: ScreenUtil().setWidth(400),
                      fit: BoxFit.contain)),
              Image.asset('assets/bet.png', width: ScreenUtil().setWidth(500))
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
      ),
      _funButton(model),
      _playTime(model),
      Positioned(bottom: 10, child: PlayButton(model))
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
      return Stack(children: <Widget>[
        Image.asset(
          'assets/timg.jpg',
          fit: BoxFit.cover,
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
