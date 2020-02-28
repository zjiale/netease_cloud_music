import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/screens/audio/audio_player_screen.dart';
import 'package:wangyiyun/store/index.dart';
import 'package:wangyiyun/store/model/play_song_model.dart';

class MiniPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Store.connect<PlaySongModel>(builder: (context, model, child) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AudioPlayerScreen()));
        },
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
                    // child: Image.network(model.curSong.picUrl)
                  )),
                  SizedBox(width: ScreenUtil().setWidth(10.0)),
                  Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        Text(
                          "model.curSong.name",
                          maxLines: 1,
                        ),
                        SizedBox(height: ScreenUtil().setHeight(6.0)),
                        Text("model.curSong.artists",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(20.0),
                                color: Colors.black54))
                      ])),
                  InkWell(
                      child:
                          Stack(alignment: Alignment.center, children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      value: 0.2,
                      strokeWidth: 1.0,
                    ),
                    Icon(Icons.pause, size: ScreenUtil().setWidth(40.0))
                  ])),
                  IconButton(
                      icon: Icon(Icons.list,
                          size: ScreenUtil().setWidth(60.0),
                          color: Colors.black54),
                      onPressed: () {}),
                ])),
      );
    });
  }
}
