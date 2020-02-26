import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/model/music_song_model.dart';
import 'package:wangyiyun/model/play_list.detail.dart';
import 'package:wangyiyun/screens/audio/audio_player_screen.dart';
import 'package:wangyiyun/store/index.dart';
import 'package:wangyiyun/store/model/play_song_model.dart';

class PlayListBottom extends StatelessWidget implements PreferredSizeWidget {
  final PlayListDetailModel detail;

  PlayListBottom(this.detail);

  void playMoreSong(BuildContext context, PlaySongModel model) {
    List<MusicSong> list = [];
    for (int i = 0; i <= detail.playlist.tracks.length - 1; i++) {
      if (detail.playlist.tracks[i].fee == 1 || detail.privileges[i].st == -200)
        continue;
      list.add(MusicSong(detail.playlist.tracks[i].id,
          totalTime: detail.playlist.tracks[i].dt,
          name: detail.playlist.tracks[i].name,
          artists: detail.playlist.tracks[i].ar.first.name,
          picUrl: detail.playlist.tracks[i].al.picUrl));
    }
    model.playMoreSong(list);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AudioPlayerScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Store.connect<PlaySongModel>(builder: (context, model, child) {
      return ClipRRect(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(ScreenUtil().setWidth(30))),
          child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
              ),
              child: InkWell(
                  onTap: () => playMoreSong(context, model),
                  child: SizedBox.fromSize(
                      size: preferredSize,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Icon(Icons.play_circle_outline,
                                  size: ScreenUtil().setWidth(50)),
                              SizedBox(width: ScreenUtil().setWidth(15.0)),
                              RichText(
                                  text: TextSpan(
                                      text: '播放全部',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(30.0),
                                          color: Colors.black),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '(共${detail.playlist.trackCount}首)',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(28.0),
                                            color: Color(0xffcdcdcd)))
                                  ]))
                            ]),
                            InkWell(
                              onTap: () {
                                print('收藏啦啦啦啦啦');
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: Row(children: <Widget>[
                                    Text('+',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(30.0),
                                            color: Colors.white)),
                                    SizedBox(
                                        width: ScreenUtil().setWidth(10.0)),
                                    Text(
                                        '收藏 (${detail.playlist.subscribedCount})',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(25.0),
                                            color: Colors.white))
                                  ])),
                            )
                          ])))));
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setWidth(100));
}
