import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neteast_cloud_music/screens/audio/audio_player_screen.dart';
import 'package:neteast_cloud_music/store/model/play_song_model.dart';
import 'package:neteast_cloud_music/utils/routes/navigator_util.dart';

class MiniPlayer extends StatelessWidget {
  final PlaySongModel model;
  MiniPlayer(this.model);

  @override
  Widget build(BuildContext context) {
    return model.curList.length > 0
        ? StreamBuilder(
            stream: model.curPositionStream,
            builder: (context, AsyncSnapshot snapshot) {
              return GestureDetector(
                onTap: () => NavigatorUtil.goAudioPage(context),
                child: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: ScreenUtil().setHeight(80.0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white.withOpacity(0.9),
                    child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipOval(
                              child: Container(
                                  width: ScreenUtil().setWidth(75.0),
                                  height: ScreenUtil().setWidth(75.0),
                                  color: Colors.orange,
                                  child: Image.network(model.curSong.picUrl))),
                          SizedBox(width: ScreenUtil().setWidth(10.0)),
                          Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Text(
                                  model.curSong.name,
                                  maxLines: 1,
                                ),
                                SizedBox(height: ScreenUtil().setHeight(6.0)),
                                Text(model.curSong.artists,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(20.0),
                                        color: Colors.black54))
                              ])),
                          GestureDetector(
                              behavior: HitTestBehavior.opaque, // 阻止冒泡事件
                              onTap: () => model.togglePlay(),
                              child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.red),
                                      value: (int.parse(
                                                  '${snapshot.data == null ? 0 : snapshot.data}') /
                                              model.curSong.totalTime)
                                          .toDouble(),
                                      strokeWidth: 1.0,
                                    ),
                                    Icon(
                                        model.curState ==
                                                AudioPlayerState.PLAYING
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        size: ScreenUtil().setWidth(40.0))
                                  ])),
                          IconButton(
                              icon: Icon(Icons.list,
                                  size: ScreenUtil().setWidth(60.0),
                                  color: Colors.black54),
                              onPressed: () {}),
                        ])),
              );
            })
        : Container();
  }
}
