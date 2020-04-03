import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neteast_cloud_music/store/model/play_song_model.dart';
import 'package:neteast_cloud_music/widgets/image_button.dart';

class PlayButton extends StatelessWidget {
  final PlaySongModel model;
  PlayButton(this.model);

  @override
  Widget build(BuildContext context) {
    String _mode;
    switch (model.mode) {
      case 0:
        _mode = 'songs_circle';
        break;
      case 1:
        _mode = "song_single_circle";
        break;
      case 2:
        _mode = "songs_random";
        break;
    }

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ImageButton(
                  ScreenUtil().setWidth(80), ScreenUtil().setHeight(80), _mode,
                  fun: () => model.changeMode()),
              ImageButton(ScreenUtil().setWidth(80), ScreenUtil().setHeight(80),
                  'song_left',
                  fun: () => model.previous()),
              ImageButton(
                  ScreenUtil().setWidth(130),
                  ScreenUtil().setHeight(130),
                  model.curState == AudioPlayerState.PLAYING
                      ? 'song_pause'
                      : 'song_play',
                  fun: () => model.togglePlay()),
              ImageButton(ScreenUtil().setWidth(80), ScreenUtil().setHeight(80),
                  'song_right',
                  fun: () => model.next()),
              ImageButton(ScreenUtil().setWidth(80), ScreenUtil().setHeight(80),
                  'play_songs',
                  fun: () {})
            ]));
  }
}
