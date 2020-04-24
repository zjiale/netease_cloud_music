<<<<<<< HEAD
import 'package:audioplayers/audioplayers.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/model/music_song_model.dart';
import 'package:wangyiyun/screens/audio/audio_player_screen.dart';
import 'package:wangyiyun/store/index.dart';
import 'package:wangyiyun/store/model/play_song_model.dart';
import 'package:wangyiyun/utils/my_special_textspan_builder.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';
=======
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neteast_cloud_music/model/music_song_model.dart';
import 'package:neteast_cloud_music/store/index.dart';
import 'package:neteast_cloud_music/store/model/play_song_model.dart';
import 'package:neteast_cloud_music/utils/my_special_textspan_builder.dart';
import 'package:neteast_cloud_music/widgets/play_list_cover.dart';
>>>>>>> new

class HomeMusicList extends StatefulWidget {
  final ScrollController controller;
  final ScrollPhysics physics;
  final List list;
  final double ratio;
  final bool isAlbum;

<<<<<<< HEAD
  HomeMusicList(this.controller, this.physics, this.list, this.ratio,
      {this.isAlbum = false});
=======
  HomeMusicList(
      {@required this.controller,
      @required this.physics,
      @required this.list,
      @required this.ratio,
      this.isAlbum = false});
>>>>>>> new
  @override
  _HomeMusicListState createState() => _HomeMusicListState();
}

class _HomeMusicListState extends State<HomeMusicList> {
  _play(int index, PlaySongModel model) {
    MusicSong song;
    if (widget.isAlbum != true) {
<<<<<<< HEAD
      song = MusicSong(widget.list[index].id,
=======
      song = MusicSong(
          id: widget.list[index].id,
>>>>>>> new
          totalTime: widget.list[index].duration,
          name: widget.list[index].name,
          artists: widget.list[index].artists.first.name,
          picUrl: widget.list[index].album.blurPicUrl);
      model.playOneSong(song);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320.0),
      child: GridView.builder(
<<<<<<< HEAD
=======
          padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40.0)),
>>>>>>> new
          scrollDirection: Axis.horizontal,
          controller: widget.controller,
          itemCount: widget.list.length,
          physics: widget.physics,
<<<<<<< HEAD
          padding: EdgeInsets.symmetric(horizontal: 10.0),
=======
>>>>>>> new
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 3,
<<<<<<< HEAD
              mainAxisSpacing: 5.0,
              //横轴间距
              crossAxisSpacing: 10.0,
=======
              //横轴间距
              crossAxisSpacing: ScreenUtil().setWidth(25.0),
>>>>>>> new
              //子组件宽高长度比例
              childAspectRatio: widget.ratio),
          itemBuilder: (BuildContext context, int index) {
            //Widget Function(BuildContext context, int index)
<<<<<<< HEAD
            return Column(children: <Widget>[
              Store.connect<PlaySongModel>(builder: (context, model, child) {
                return GestureDetector(
                    onTap: () => _play(index, model),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(children: <Widget>[
                        PlayListCoverWidget(
                          widget.isAlbum != true
                              ? widget.list[index].album.blurPicUrl
                              : widget.list[index].blurPicUrl,
                          width: 100,
                          isAlbum: widget.isAlbum,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10.0)),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              ExtendedText(
                                  '${widget.list[index].name} @s- ${widget.list[index].artists.first.name}@',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  specialTextSpanBuilder:
                                      MySpecialTextSpanBuilder(),
                                  overFlowTextSpan:
                                      OverFlowTextSpan(children: <TextSpan>[
                                    TextSpan(text: '\u2026  '),
                                    TextSpan(
                                        text:
                                            "- ${widget.list[index].artists.first.name}",
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(20.0),
                                            color: Colors.grey))
                                  ])),
                              SizedBox(height: ScreenUtil().setHeight(8.0)),
                              !widget.isAlbum
                                  ? Text('${widget.list[index].album.name}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(20.0),
                                          color: Colors.grey))
                                  : Container()
                            ])),
                        SizedBox(width: ScreenUtil().setWidth(13.0)),
                        !widget.isAlbum
                            ? Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: model.curList.length > 0 &&
                                        model.curSong.id ==
                                            widget.list[index].id
                                    ? Icon(Icons.volume_up,
                                        size: ScreenUtil().setWidth(40.0),
                                        color: Theme.of(context).primaryColor)
                                    : Container(
                                        width: ScreenUtil().setWidth(45.0),
                                        height: ScreenUtil().setWidth(45.0),
                                        // padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xffcdcdcd),
                                                width: 1.0)),
                                        child: Center(
                                            child: Icon(Icons.play_arrow,
                                                size: ScreenUtil().setSp(30.0),
                                                color: Theme.of(context)
                                                    .primaryColor))))
                            : Container(
                                width: 30.0,
                                padding: EdgeInsets.only(right: 10.0))
                      ]),
                    ));
              })
            ]);
=======
            return Store.connect<PlaySongModel>(
                builder: (context, model, child) {
              return GestureDetector(
                  onTap: () => _play(index, model),
                  child: Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(10.0)),
                    child: Row(children: <Widget>[
                      PlayListCoverWidget(
                        widget.isAlbum != true
                            ? widget.list[index].album.blurPicUrl
                            : widget.list[index].blurPicUrl,
                        width: 100,
                        isAlbum: widget.isAlbum,
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10.0)),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            ExtendedText(
                                '${widget.list[index].name} @start- ${widget.list[index].artists.first.name}@',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                specialTextSpanBuilder:
                                    MySpecialTextSpanBuilder(),
                                overFlowTextSpan:
                                    OverFlowTextSpan(children: <TextSpan>[
                                  TextSpan(text: '\u2026  '),
                                  TextSpan(
                                      text:
                                          "- ${widget.list[index].artists.first.name}",
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(20.0),
                                          color: Colors.grey))
                                ])),
                            SizedBox(height: ScreenUtil().setHeight(8.0)),
                            !widget.isAlbum
                                ? Text('${widget.list[index].album.name}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(20.0),
                                        color: Colors.grey))
                                : Container()
                          ])),
                      SizedBox(width: ScreenUtil().setWidth(13.0)),
                      !widget.isAlbum
                          ? Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: model.curList.length > 0 &&
                                      model.curSong.id == widget.list[index].id
                                  ? Icon(Icons.volume_up,
                                      size: ScreenUtil().setWidth(40.0),
                                      color: Theme.of(context).primaryColor)
                                  : Container(
                                      width: ScreenUtil().setWidth(45.0),
                                      height: ScreenUtil().setWidth(45.0),
                                      // padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Color(0xffcdcdcd),
                                              width: 1.0)),
                                      child: Center(
                                          child: Icon(Icons.play_arrow,
                                              size: ScreenUtil().setSp(30.0),
                                              color: Theme.of(context)
                                                  .primaryColor))))
                          : Container(
                              width: 30.0,
                              padding: EdgeInsets.only(right: 10.0))
                    ]),
                  ));
            });
>>>>>>> new
          }),
    );
  }
}
