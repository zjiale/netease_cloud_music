import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neteast_cloud_music/store/model/play_video_model.dart';
import 'package:neteast_cloud_music/widgets/custom_event_fijl_panel.dart';
import 'package:neteast_cloud_music/model/event_content_model.dart';
import 'package:neteast_cloud_music/model/video_url_model.dart';
import 'package:neteast_cloud_music/api/CommonService.dart';
import 'package:neteast_cloud_music/utils/config.dart';

class ListItemPlayer extends StatefulWidget {
  final PlayVideoModel videoModel;
  final int index;
  final Video videoContent;

  ListItemPlayer(
      {@required this.videoModel,
      @required this.index,
      @required this.videoContent});

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

    if (widget.videoModel.canplay) {
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

    if (_player != null && widget.index == widget.videoModel.index) {
      _expectStart = true;
      _player.removeListener(pauseListener);
      if (_start == false && _player.isPlayable()) {
        _player.start();
        _start = true;
        widget.videoModel.stopPlay();
      } else if (_start == false) {
        _player.addListener(startListener);
        widget.videoModel.stopPlay();
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
    finalizer();
  }

  @override
  Widget build(BuildContext context) {
    FijkFit fit = FijkFit(
      sizeFactor: 1.0,
      aspectRatio: widget.videoContent.width / widget.videoContent.height,
      alignment: Alignment.center,
    );
    return Container(
        height: 180,
        child: Column(
          children: <Widget>[
            Expanded(
              child: _player != null
                  ? Container(
                      child: FijkView(
                        color: Colors.black,
                        player: _player,
                        fit: fit,
                        panelBuilder: _eventFijkPanelBuilder,
                        cover: NetworkImage("${widget.videoContent.coverUrl}"),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: ExtendedImage.network(
                          "${widget.videoContent.coverUrl}"),
                    ),
            )
          ],
        ));
  }
}
