import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neteast_cloud_music/widgets/custom_event_fijl_panel.dart';
import 'package:neteast_cloud_music/model/event_content_model.dart';
import 'package:neteast_cloud_music/model/video_url_model.dart';
import 'package:neteast_cloud_music/api/CommonService.dart';
import 'package:neteast_cloud_music/utils/config.dart';

class ListItemPlayer extends StatefulWidget {
  final int index;
  final ValueNotifier<double> notifier;
  final Video videoContent;

  ListItemPlayer(
      {@required this.index,
      @required this.notifier,
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

    widget.notifier.addListener(scrollListener);
    int mills = widget.index <= 3 ? 100 : 500;
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

  void scrollListener() {
    if (!mounted) return;

    /// !!important
    /// If items in your list view have different height,
    /// You can't get the first visible item index by
    /// dividing a constant height simply
    double pixels = widget.notifier.value;

    int x = (pixels / 200).ceil();
    if (_player != null && widget.index == x) {
      _expectStart = true;
      _player.removeListener(pauseListener);
      if (_start == false && _player.isPlayable()) {
        // FijkLog.i("start from scroll listener $_player");
        _player.start();
        _start = true;
      } else if (_start == false) {
        // FijkLog.i("add start listener $_player");
        _player.addListener(startListener);
      }
    } else if (_player != null) {
      _expectStart = false;
      _player.removeListener(startListener);
      if (_player.isPlayable() && _start) {
        // FijkLog.i("pause from scroll listener $_player");
        _player.pause();
        _start = false;
      } else if (_start) {
        // FijkLog.i("add pause listener $_player");
        _player.addListener(pauseListener);
      }
    }
  }

  void startListener() {
    FijkValue value = _player.value;
    if (value.prepared && !_start && _expectStart) {
      _start = true;
      // FijkLog.i("start from player listener $_player");
      _player.start();
    }
  }

  void pauseListener() {
    FijkValue value = _player.value;
    if (value.prepared && _start && !_expectStart) {
      _start = false;
      // FijkLog.i("pause from player listener $_player");
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
    widget.notifier.removeListener(scrollListener);
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
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _player != null
                  ? FijkView(
                      player: _player,
                      fit: fit,
                      panelBuilder: _eventFijkPanelBuilder,
                      cover: NetworkImage("${widget.videoContent.coverUrl}"),
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
