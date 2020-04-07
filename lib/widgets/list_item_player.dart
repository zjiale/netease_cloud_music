import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/store/model/play_video_model.dart';
import 'package:netease_cloud_music/widgets/custom_event_fijl_panel.dart';
import 'package:netease_cloud_music/model/event_content_model.dart';
import 'package:netease_cloud_music/model/video_url_model.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/utils/config.dart';

class ListItemPlayer extends StatefulWidget {
  final PlayVideoModel videoModel;
  final int index;
  final Video videoContent;
  final bool isDetail;

  ListItemPlayer(
      {@required this.videoModel,
      @required this.index,
      @required this.videoContent,
      this.isDetail = false});

  @override
  _ListItemPlayerState createState() => _ListItemPlayerState();
}

class _ListItemPlayerState extends State<ListItemPlayer> {
  FijkPlayer _player;
  Timer _timer;
  bool _start = false;
  bool _expectStart = false;

  int _code = Config.SUCCESS_CODE;

  @override
  void initState() {
    super.initState();

    /// 判断list中的视频
    widget.videoModel.index.addListener(() {
      if (widget.videoModel.index.value != widget.index && _player != null) {
        finalizer();
        if (mounted) {
          setState(() {});
        }
      }
    });

    /// 用于判断详情里面的视频是否能够播放
    widget.videoModel.canplay.addListener(() {
      if (!widget.videoModel.canplay.value && _player != null) {
        finalizer();
        widget.videoModel.stopPlay();
        if (mounted) {
          setState(() {});
        }
      }
    });

    if (widget.index == widget.videoModel.index.value ||
        (widget.videoModel.canplay.value && widget.isDetail)) {
      int mills = 500;
      _timer = Timer(Duration(milliseconds: mills), () async {
        _player = FijkPlayer();

        String _url = "";
        await CommmonService()
            .getVideoUrl(widget.videoContent.videoId)
            .then((res) {
          VideoUrlModel _bean = VideoUrlModel.fromJson(res.data);
          if (_bean.code == _code) {
            _url = _bean.urls.first.url;
          }
        });

        await _player?.setVolume(0.0);
        await _player?.setDataSource(_url);
        await _player?.prepareAsync();
        scrollListener();
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  void scrollListener() {
    if (!mounted) return;

    if (_player != null) {
      _expectStart = true;
      _player.removeListener(pauseListener);
      if (_start == false && _player.isPlayable()) {
        _player.start();
        _start = true;
      } else if (_start == false) {
        _player.addListener(startListener);
      }
    }
  }

  void startListener() {
    FijkValue value = _player.value;
    if (value.prepared && !_start && _expectStart) {
      _start = true;
      _player.start();
    }
  }

  void pauseListener() {
    FijkValue value = _player.value;
    if (value.prepared && _start && !_expectStart) {
      _start = false;
      _player?.pause();
    }
  }

  void finalizer() {
    _player?.removeListener(startListener);
    _player?.removeListener(pauseListener);
    var player = _player;
    _player = null;
    player?.release();
  }

  Widget _eventFijkPanelBuilder(FijkPlayer player, FijkData data,
      BuildContext context, Size viewSize, Rect texturePos) {
    return CustomEventFijkPanel(
        player: player,
        buildContext: context,
        viewSize: viewSize,
        texturePos: texturePos);
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    FijkFit fit = FijkFit(
      sizeFactor: 1.0,
      aspectRatio: widget.videoContent.width / widget.videoContent.height,
      alignment: Alignment.center,
    );
    return Container(
        height: ScreenUtil().setWidth(300.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _player != null
                  ? Stack(
                      children: <Widget>[
                        FijkView(
                          height: ScreenUtil().setWidth(300.0),
                          color: Colors.black,
                          player: _player,
                          fit: FijkFit.contain,
                          panelBuilder: _eventFijkPanelBuilder,
                          cover:
                              NetworkImage("${widget.videoContent.coverUrl}"),
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setWidth(10.0)),
                              child: RichText(
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
                                      text: "${widget.videoContent.playTime}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(23.0)))
                                ]),
                              ),
                            ))
                      ],
                    )
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          ExtendedImage.network(
                              "${widget.videoContent.coverUrl}",
                              colorBlendMode: BlendMode.srcOver,
                              color: Colors.black26),
                          Icon(
                            Icons.play_arrow,
                            size: ScreenUtil().setSp(70.0),
                            color: Colors.white70,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setWidth(10.0)),
                              child: RichText(
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
                                      text: "${widget.videoContent.playTime}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(23.0)))
                                ]),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setWidth(10.0)),
                                child: Text(
                                    DateUtil.formatDateMs(
                                        widget.videoContent.duration * 1000,
                                        format: "mm:ss"),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(23.0)))),
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ));
  }
}
