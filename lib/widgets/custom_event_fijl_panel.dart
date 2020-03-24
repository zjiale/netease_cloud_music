import 'dart:async';
import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomEventFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final BuildContext buildContext;
  final Size viewSize;
  final Rect texturePos;

  const CustomEventFijkPanel({
    @required this.player,
    this.buildContext,
    this.viewSize,
    this.texturePos,
  });

  @override
  _CustomEventFijkPanelState createState() => _CustomEventFijkPanelState();
}

class _CustomEventFijkPanelState extends State<CustomEventFijkPanel>
    with TickerProviderStateMixin {
  FijkPlayer get player => widget.player;

  Duration _duration = Duration();
  Duration _currentPos = Duration();
  Duration _bufferPos = Duration();

  bool _playing = false;
  bool _prepared = false;
  String _exception;

  StreamSubscription _currentPosSubs;

  StreamSubscription _bufferPosSubs;

  double _volume = 0.0;
  final double barHeight = ScreenUtil().setHeight(50.0);

  @override
  void initState() {
    super.initState();

    _duration = player.value.duration;
    _currentPos = player.currentPos;
    _bufferPos = player.bufferPos;
    _prepared = player.state.index >= FijkState.prepared.index;
    _playing = player.state == FijkState.started;
    _exception = player.value.exception.message;

    widget.player.addListener(_playerValueChanged);

    _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
      setState(() {
        _currentPos = v;
      });
    });

    _bufferPosSubs = player.onBufferPosUpdate.listen((v) {
      setState(() {
        _bufferPos = v;
      });
    });
  }

  void _playerValueChanged() {
    FijkValue value = player.value;
    if (value.duration != _duration) {
      setState(() {
        _duration = value.duration;
      });
    }

    bool playing = (value.state == FijkState.started);
    bool prepared = value.prepared;
    String exception = value.exception.message;
    if (playing != _playing ||
        prepared != _prepared ||
        exception != _exception) {
      setState(() {
        _playing = playing;
        _prepared = prepared;
        _exception = exception;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    player.removeListener(_playerValueChanged);
    _currentPosSubs?.cancel();
    _bufferPosSubs?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = Rect.fromLTRB(
        max(0.0, widget.texturePos.left),
        max(0.0, widget.texturePos.top),
        min(widget.viewSize.width, widget.texturePos.right),
        min(widget.viewSize.height, widget.texturePos.bottom));

    return Positioned.fromRect(
      rect: rect,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: barHeight),
          _exception != null
              ? Text(
                  _exception,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )
              : (_prepared || player.state == FijkState.initialized)
                  ? Offstage(
                      offstage:
                          player.state == FijkState.started ? true : false,
                      child: Icon(
                        Icons.play_arrow,
                        size: ScreenUtil().setSp(50.0),
                        color: Colors.white,
                      ),
                    )
                  : Container(
                      height: ScreenUtil().setWidth(80.0),
                      width: ScreenUtil().setWidth(80.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black26,
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Transform.rotate(
                          angle: -(pi / 2),
                          child: Icon(
                            Icons.replay,
                            size: ScreenUtil().setSp(50.0),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(children: [
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Container(
                          margin: EdgeInsets.only(
                              right: ScreenUtil().setWidth(5.0)),
                          child: Icon(
                            Icons.play_arrow,
                            size: ScreenUtil().setSp(25.0),
                            color: Colors.white,
                          ),
                        )),
                    TextSpan(
                        text: "2375",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(23.0)))
                  ]),
                ),
                Text(
                    _currentPos.inMilliseconds != _duration.inMilliseconds
                        ? DateUtil.formatDateMs(
                            _duration.inMilliseconds -
                                _currentPos.inMilliseconds,
                            format: "mm:ss")
                        : DateUtil.formatDateMs(_duration.inMilliseconds,
                            format: "mm:ss"),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(23.0)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
