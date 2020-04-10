import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/music_song_model.dart';
import 'package:netease_cloud_music/utils/numbers_convert.dart';
import 'package:netease_cloud_music/widgets/play_list_cover.dart';

class SongItem extends StatelessWidget {
  final bool showIndex;
  final bool showPic;
  final bool isSearch;
  final int type;
  final MusicSong detail;
  final int index;

  SongItem(
      {this.showIndex = false,
      this.showPic = false,
      this.isSearch = false,
      this.type = 0, // 0: 歌曲 1: 专辑 2: 歌单
      this.detail,
      this.index = 0});

  @override
  Widget build(BuildContext context) {
    Widget _buildSubTitle() {
      switch (type) {
        case 1:
          return Text(
              '${detail.artists}${detail.artistsTrans != '' ? (detail.artistsTrans) : ''} ${DateUtil.formatDateMs(detail.publishTime, format: "yyyy-MM-dd")}',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(20.0), color: Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis);
          break;
        case 2:
          return Text(
              '${detail.total}首 by ${detail.artists}, 播放${NumberUtils.formatNum(detail.count)}次',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(20.0), color: Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis);
          break;
        default:
          return Row(
            children: <Widget>[
              Offstage(
                offstage: !detail.isHighQuality,
                child: Container(
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(5.0)),
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
                offstage: !detail.isVip,
                child: Container(
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(5.0)),
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
                        color:
                            detail.st == -200 ? Colors.grey : Colors.black54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          );
      }
    }

    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Offstage(
            offstage: showIndex,
            child: Container(
              width: ScreenUtil().setWidth(60.0),
              child: Center(
                child: Text('${1 + index}',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(30.0),
                        color: Colors.black45)),
              ),
            ),
          ),
          showPic
              ? PlayListCoverWidget(
                  detail.picUrl,
                  circular: type == 0 ? 8.0 : 5.0,
                  width: type == 0 ? 80.0 : 100,
                  isAlbum: type == 1 ? true : false,
                )
              : Container(),
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
                              color: detail.st == -200
                                  ? Colors.grey
                                  : Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: detail.subName != ''
                                    ? '（${detail.subName}）'
                                    : '',
                                style: TextStyle(color: Colors.grey))
                          ])),
                  subtitle: _buildSubTitle(),
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
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
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
                      isSearch
                          ? Container()
                          : IconButton(
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
