import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
<<<<<<< HEAD
import 'package:wangyiyun/model/music_song_model.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';

class SongItem extends StatelessWidget {
  final bool showIndex;
  final MusicSong detail;
  final int index;

  SongItem({this.showIndex = false, this.detail, this.index});
=======
import 'package:neteast_cloud_music/model/music_song_model.dart';
import 'package:neteast_cloud_music/widgets/play_list_cover.dart';

class SongItem extends StatelessWidget {
  final bool showIndex;
  final bool showPic;
  final MusicSong detail;
  final int index;

  SongItem(
      {this.showIndex = false, this.showPic = false, this.detail, this.index});
>>>>>>> new

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: <
        Widget>[
      Offstage(
        offstage: showIndex,
        child: Container(
          width: ScreenUtil().setWidth(60.0),
          child: Center(
<<<<<<< HEAD
            child: Text('${0 + index}',
=======
            child: Text('${1 + index}',
>>>>>>> new
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(30.0), color: Colors.black45)),
          ),
        ),
      ),
<<<<<<< HEAD
      PlayListCoverWidget(detail.picUrl, width: 80.0),
=======
      showPic ? PlayListCoverWidget(detail.picUrl, width: 80.0) : Container(),
>>>>>>> new
      Expanded(
          child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 12.0),
              title: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: detail.name,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28.0),
                          color:
                              detail.st == -200 ? Colors.grey : Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: detail.subName != ''
                                ? '（${detail.subName}）'
                                : '',
                            style: TextStyle(color: Colors.grey))
                      ])),
              subtitle: Row(
                children: <Widget>[
                  Offstage(
                    offstage: !detail.isHighQuality,
                    child: Container(
                      margin:
                          EdgeInsets.only(right: ScreenUtil().setWidth(5.0)),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 1.0, color: Colors.red)),
                      padding: EdgeInsets.symmetric(horizontal: 1.0),
                      child: Text('SQ',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(15.0),
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    ),
                  ),
                  Offstage(
                    child: Container(
                      margin:
                          EdgeInsets.only(right: ScreenUtil().setWidth(5.0)),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 1.0, color: Colors.red)),
                      padding: EdgeInsets.symmetric(horizontal: 1.0),
                      child: Text('VIP',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(15.0),
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    ),
                  ),
                  Flexible(
                    child: Text('${detail.artists} - ${detail.album}',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(20.0),
                            color: detail.st == -200
                                ? Colors.grey
                                : Colors.black54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Offstage(
                    offstage: detail.mvid == 0 ? true : false,
                    child: Container(
                      width: ScreenUtil().setWidth(35.0),
                      height: ScreenUtil().setWidth(30.0),
                      margin: EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 1.0, color: Colors.grey),
                          borderRadius: BorderRadius.circular(6.0)),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: ScreenUtil().setWidth(20.0),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  )
                ],
              )))
    ]);
  }
}
