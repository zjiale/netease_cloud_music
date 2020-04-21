import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/event_content_model.dart';
import 'package:netease_cloud_music/model/event_model.dart';
import 'package:netease_cloud_music/model/music_song_model.dart';
import 'package:netease_cloud_music/netease_cloud_music_route.dart';
import 'package:netease_cloud_music/screens/audio/audio_player_screen.dart';
import 'package:netease_cloud_music/screens/playlist/play_list_detail_screen.dart';
import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/store/model/play_song_model.dart';
import 'package:netease_cloud_music/store/model/play_video_model.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:netease_cloud_music/utils/my_special_textspan_builder.dart';
import 'package:netease_cloud_music/widgets/fade_network_image.dart';
import 'package:netease_cloud_music/widgets/list_item_player.dart';
import 'package:netease_cloud_music/widgets/play_list_cover.dart';
import 'package:rect_getter/rect_getter.dart';

class EventDescription extends StatefulWidget {
  final Events event;
  final PlaySongModel model;
  final bool isDetail;
  final int index;
  final callback;
  EventDescription(
      {@required this.event,
      this.model,
      this.index,
      this.callback,
      this.isDetail = false});

  @override
  _EventDescriptionState createState() => _EventDescriptionState();
}

class _EventDescriptionState extends State<EventDescription> {
  var _keys = {};

  Widget _defaultContent(
      {@required String url,
      @required String title,
      @required String creator,
      bool isSong = false,
      bool isTopic = false}) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10.0)),
      decoration: BoxDecoration(
          color: Color(0xfff1f1f1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Row(
        children: <Widget>[
          isTopic
              ? Container()
              : Container(
                  width: ScreenUtil().setWidth(70.0),
                  height: ScreenUtil().setWidth(70.0),
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(10.0)),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      image: DecorationImage(image: NetworkImage(url))),
                  child: isSong
                      ? Center(
                          child: Container(
                          width: ScreenUtil().setWidth(30.0),
                          height: ScreenUtil().setWidth(30.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white70),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.red,
                              size: ScreenUtil().setWidth(20.0),
                            ),
                          ),
                        ))
                      : Container(),
                ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ExtendedText.rich(
                    TextSpan(children: [
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: !isSong
                              ? Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  margin: EdgeInsets.only(right: 3.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.0)),
                                      border: Border.all(color: Colors.red)),
                                  child: Text(
                                    isTopic ? "专栏" : "歌单",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: ScreenUtil().setSp(18.0)),
                                  ),
                                )
                              : Text('')),
                      TextSpan(
                          text: title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(26.0)))
                    ]),
                    maxLines: isTopic ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    overFlowTextSpan: OverFlowTextSpan(
                        children: <TextSpan>[TextSpan(text: '\u2026')])),
                SizedBox(
                  height: ScreenUtil().setHeight(5.0),
                ),
                Text(
                  isSong ? creator : "by $creator",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenUtil().setSp(20.0)),
                )
              ],
            ),
          ),
          isTopic
              ? ExtendedImage.network(
                  url,
                  height: ScreenUtil().setHeight(110.0),
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _bottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      "assets/icon_event_share.png",
                      width: ScreenUtil().setWidth(30.0),
                      height: ScreenUtil().setWidth(30.0),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(5.0),
                    ),
                    Text(
                      "${widget.event.info.shareCount > 0 ? widget.event.info.shareCount : '转发'}",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(23.0),
                          color: Colors.black54),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      "assets/icon_event_comment.png",
                      width: ScreenUtil().setWidth(30.0),
                      height: ScreenUtil().setWidth(30.0),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(5.0),
                    ),
                    Text(
                      "${widget.event.info.commentCount > 0 ? widget.event.info.commentCount : '评论'}",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(23.0),
                          color: Colors.black54),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      "assets/icon_event_liked.png",
                      width: ScreenUtil().setWidth(30.0),
                      height: ScreenUtil().setWidth(30.0),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(5.0),
                    ),
                    Text(
                      "${widget.event.info.likedCount > 0 ? widget.event.info.likedCount : '喜欢'}",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(23.0),
                          color: Colors.black54),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
            size: ScreenUtil().setSp(25.0),
            color: Colors.black54,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    EventContentModel _content =
        EventContentModel.fromJson(json.decode(widget.event.json));
    Widget _picList;
    Widget _main = Container();

    String _subTitle = "";

    switch (widget.event.type) {
      case 13: //分享歌单
        _subTitle = "分享歌单";
        _main = InkWell(
          onTap: () {
            Navigator.pushNamed(
                context, Routes.NETEASECLOUDMUSIC_PLAYLISTDETAILSCREEN,
                arguments: {
                  "expandedHeight": 520.0,
                  "id": _content.playlist.id,
                  "official": false,
                });
          },
          child: _defaultContent(
              url: _content.playlist.coverImgUrl,
              title: _content.playlist.name,
              creator: _content.playlist.creator.nickname),
        );
        break;
      case 18: //分享歌曲
        List _list = [];
        _content.song.artists.forEach((artist) {
          _list.add(artist.name);
        });
        _subTitle = "分享歌曲";
        _main = InkWell(
          onTap: () {
            MusicSong song = MusicSong(
                id: _content.song.id,
                duration: _content.song.duration,
                name: _content.song.name,
                artists: Config().formatArtist(_list),
                picUrl: _content.song.album.picUrl);
            widget.model.playOneSong(song);

            Navigator.pushNamed(
                context, Routes.NETEASECLOUDMUSIC_AUDIOPLAYERSCREEN);
          },
          child: _defaultContent(
              url: _content.song.album.blurPicUrl,
              title: _content.song.name,
              creator: Config().formatArtist(_list),
              isSong: true),
        );
        break;
      case 22: //转发
        _subTitle = "转发";
        break;
      case 24: //分享专栏文章
        _subTitle = "分享专栏文章";
        _main = _defaultContent(
            url: _content.topic.rectanglePicUrl,
            title: _content.topic.mainTitle,
            creator: _content.topic.creator.nickname,
            isTopic: true);
        break;
      case 35: //分享内容
        // _subTitle = "分享歌单";
        break;
      case 39: //发布视频
        _subTitle = "发布视频";

        /// 返回生成的key在上一级中进行筛选
        _keys[widget.index] = RectGetter.createGlobalKey();
        if (widget.isDetail) {
          widget.callback(_keys[widget.index]);
        } else {
          widget.callback(_keys);
        }
        _main = Store.connect<PlayVideoModel>(
            builder: (context, videoModel, child) {
          return RectGetter(
            key: _keys[widget.index],
            child: ListItemPlayer(
                isDetail: widget.isDetail,
                videoModel: videoModel,
                index: widget.index,
                videoContent: _content.video),
          );
        });

        break;
      default:
    }

    String _eventTime = DateUtil.yearIsEqual(
            DateTime.fromMillisecondsSinceEpoch(widget.event.showTime),
            DateTime.now())
        ? DateUtil.isToday(widget.event.showTime)
            ? "${DateUtil.formatDateMs(widget.event.showTime, format: DataFormats.h_m)}"
            : DateUtil.isYesterday(
                    DateTime.fromMillisecondsSinceEpoch(widget.event.showTime),
                    DateTime.now())
                ? "昨天${DateUtil.formatDateMs(widget.event.showTime, format: DataFormats.h_m)}"
                : "${DateUtil.formatDateMs(widget.event.showTime, format: 'M月dd日')}"
        : "${DateUtil.formatDateMs(widget.event.showTime, format: 'yyyy/M/d')}";

    switch (widget.event.pics.length) {
      case 0:
        _picList = Container();
        break;
      case 1:
        _picList = ExtendedImage.network(
          widget.event.pics.first.originUrl,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          width: widget.event.pics.first.width > widget.event.pics.first.height
              ? ScreenUtil().setWidth(338)
              : null,
          height: widget.event.pics.first.width > widget.event.pics.first.height
              ? null
              : ScreenUtil().setHeight(338),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        );
        break;
      default:
        _picList = Container(
          width: widget.event.pics.length == 4
              ? widget.isDetail
                  ? ScreenUtil().setWidth(470)
                  : ScreenUtil().setWidth(385)
              : null,
          child: GridView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.event.pics.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.event.pics.length == 4 ? 2 : 3,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("");
                  },
                  child: PlayListCoverWidget(
                    widget.event.pics[index].squareUrl,
                    width: widget.isDetail ? 230.0 : 190.0,
                    fit: BoxFit.cover,
                    circular: 3.0,
                  ),
                );
              }),
        );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30.0)),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                  alignment: Alignment.center,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    ClipOval(
                      child: FadeNetWorkImage(
                        widget.event.user.avatarUrl,
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(70.0),
                      ),
                    ),
                    widget.event.pendantData != null
                        ? FadeNetWorkImage(
                            widget.isDetail
                                ? widget.event.pendantData.imageAndroidUrl
                                : widget.event.pendantData.imageUrl,
                            width: ScreenUtil().setWidth(90.0),
                            pendantData: true,
                          )
                        : SizedBox()
                  ]),
              // SizedBox(width: ScreenUtil().setWidth(20.0)),
              Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(10.0)),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    Row(children: <Widget>[
                      Text(widget.event.user.nickname,
                          style: TextStyle(color: Colors.blue)),
                      SizedBox(
                        width: ScreenUtil().setWidth(10.0),
                      ),
                      Text(_subTitle,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: ScreenUtil().setSp(25.0))),
                    ]),
                    SizedBox(
                      height: ScreenUtil().setHeight(5.0),
                    ),
                    Text(
                      _eventTime,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScreenUtil().setSp(20.0)),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: widget.isDetail
                ? EdgeInsets.only(left: 5.0)
                : EdgeInsets.only(left: ScreenUtil().setWidth(90.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil().setHeight(20.0),
                ),
                ExtendedText(
                  "${_content.msg} ",
                  softWrap: true,
                  strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5),
                  specialTextSpanBuilder: MySpecialTextSpanBuilder(),
                ),
                SizedBox(height: ScreenUtil().setHeight(8.0)),
                _picList,
                SizedBox(height: ScreenUtil().setHeight(8.0)),
                _main,
                widget.isDetail ? Container() : _bottom(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
