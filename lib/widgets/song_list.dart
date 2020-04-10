import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:netease_cloud_music/model/music_song_model.dart';
import 'package:netease_cloud_music/model/play_list.detail.dart';
import 'package:netease_cloud_music/model/subscribers_model.dart';
import 'package:netease_cloud_music/screens/playlist/play_list_bottom.dart';
import 'package:netease_cloud_music/screens/playlist/play_list_description.dart';
import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/store/model/play_song_model.dart';
import 'package:netease_cloud_music/utils/numbers_convert.dart';
import 'package:netease_cloud_music/utils/routes/navigator_util.dart';
import 'package:netease_cloud_music/widgets/fade_network_image.dart';
import 'package:netease_cloud_music/widgets/play_list_cover.dart';
import 'package:netease_cloud_music/widgets/sliver_appbar_custom.dart';
import 'package:netease_cloud_music/widgets/song_item.dart';

class SongList extends StatefulWidget {
  final double expandedHeight;
  final int id;
  final PlayListDetailModel detail;
  final List<MusicSong> list;
  final List<SubscribersModel> suscribers;
  final Color bgColor;
  final Widget playlistbutton;
  final bool official;
  SongList(
      {@required this.expandedHeight,
      @required this.id,
      @required this.detail,
      @required this.list,
      @required this.suscribers,
      @required this.bgColor,
      @required this.playlistbutton,
      this.official = false});

  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  bool _marquee = false;

  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      double ratio = (window.physicalSize.width / 3) /
          750; // 将px转为dp然后再除以750获取像素比，相关文档看screenutil转换原理
      if (_controller.offset >= 120 * ratio && !_marquee) {
        setState(() {
          _marquee = true;
        });
      } else if (_controller.offset < 120 * ratio && _marquee) {
        setState(() {
          _marquee = false;
        });
      }
    });
  }

  Future _showDesc(BuildContext context, PlayListDetailModel detail) {
    return showGeneralDialog(
        context: context,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, Animation<double> firstAnimation,
            Animation<double> secondAnimation) {
          return PlayListDescription(
            bgColor: widget.bgColor,
            detail: detail,
          );
        });
  }

  Widget _normalDesc() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      PlayListCoverWidget(widget.detail.playlist.coverImgUrl,
          width: 230,
          playCount:
              NumberUtils.amountConversion(widget.detail.playlist.playCount)),
      SizedBox(width: ScreenUtil().setWidth(40.0)),
      Expanded(
          child: Container(
        height: ScreenUtil().setWidth(230),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.detail.playlist.name,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(33.0),
                      fontWeight: FontWeight.bold)),
              Row(children: <Widget>[
                ClipOval(
                    child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: ExtendedImage.network(
                      widget.detail.playlist.creator.avatarUrl,
                      fit: BoxFit.cover),
                )),
                SizedBox(width: ScreenUtil().setWidth(10.0)),
                Flexible(
                  child: Text(widget.detail.playlist.creator.nickname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25.0),
                          color: Color(0xffcdcdcd))),
                ),
                Icon(Icons.keyboard_arrow_right,
                    size: ScreenUtil().setSp(40.0), color: Color(0xffcdcdcd))
              ]),
              GestureDetector(
                onTap: () => _showDesc(context, widget.detail),
                child: Row(children: <Widget>[
                  Flexible(
                    child: Text(widget.detail.playlist.description,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(20.0),
                            color: Color(0xffcdcdcd)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Icon(Icons.keyboard_arrow_right,
                      size: ScreenUtil().setSp(40.0), color: Color(0xffcdcdcd))
                ]),
              )
            ]),
      ))
    ]);
  }

  Widget _officialDesc() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(right: ScreenUtil().setWidth(40.0)),
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(widget.detail.playlist.name,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(33.0),
                      fontWeight: FontWeight.bold)),
              Container(
                height: ScreenUtil().setHeight(30.0),
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(5.0),
                    vertical: ScreenUtil().setHeight(3.0)),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2.0),
                    color: Colors.white.withOpacity(0.3)),
                child: Text(
                  "每日更新",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(18.0), color: Colors.grey),
                ),
              ),
              GestureDetector(
                onTap: () => _showDesc(context, widget.detail),
                child: Text(widget.detail.playlist.description,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(20.0),
                        color: Color(0xffcdcdcd)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              )
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Store.connect<PlaySongModel>(builder: (context, model, child) {
      return CustomScrollView(controller: _controller, slivers: <Widget>[
        SliverAppBarCustom(
            expandedHeight: widget.expandedHeight,
            title: _marquee
                ? Container(
                    height: ScreenUtil().setHeight(80),
                    child: MarqueeWidget(
                      text: widget.detail.playlist.name,
                      scrollAxis: Axis.horizontal,
                    ),
                  )
                : Text('歌单'),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              )
            ],
            content: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(35),
                  right: ScreenUtil().setWidth(35),
                  top: ScreenUtil().setWidth(120),
                ),
                child: Column(children: <Widget>[
                  !widget.official ? _normalDesc() : _officialDesc(),
                  SizedBox(height: ScreenUtil().setHeight(30.0)),
                  widget.playlistbutton
                ]),
              ),
            ),
            background: Stack(
              children: <Widget>[
                FadeNetWorkImage(widget.detail.playlist.coverImgUrl,
                    fit: BoxFit.fitWidth),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaY: widget.official ? 1 : 20,
                    sigmaX: widget.official ? 1 : 20,
                  ),
                  child: Container(
                    color: Colors.black54,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ],
            ),
            bottom: PlayListBottom(detail: widget.detail, model: model)),
        SliverPadding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(20.0)),
          sliver: SliverFixedExtentList(
            itemExtent: ScreenUtil().setHeight(100.0),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return GestureDetector(
                onTap: () => model.playOneSong(MusicSong(
                    id: widget.detail.playlist.tracks[index].id,
                    total: widget.detail.playlist.tracks[index].dt,
                    name: widget.detail.playlist.tracks[index].name,
                    artists: widget.detail.playlist.tracks[index].ar.first.name,
                    picUrl: widget.detail.playlist.tracks[index].al.picUrl)),
                child: SongItem(
                  index: index,
                  showIndex: false,
                  showPic: widget.list[index].picUrl == null ? false : true,
                  detail: widget.list[index],
                ),
              );
            }, childCount: widget.detail.playlist.trackCount),
          ),
        ),
        SliverToBoxAdapter(
            child: widget.suscribers.length > 0
                ? GestureDetector(
                    onTap: () =>
                        NavigatorUtil.goSubscribersPage(context, id: widget.id),
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(30.0),
                          right: ScreenUtil().setWidth(20.0)),
                      height: ScreenUtil().setHeight(100.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                                children: widget.suscribers
                                    .sublist(0, 5)
                                    .map((subscriber) {
                              return Container(
                                width: ScreenUtil().setWidth(60.0),
                                height: ScreenUtil().setWidth(60.0),
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(20.0)),
                                child: ClipOval(
                                  child: ExtendedImage.network(
                                      subscriber.avatarUrl),
                                ),
                              );
                            }).toList()),
                          ),
                          Text(
                            "${NumberUtils.amountConversion(widget.detail.playlist.subscribedCount)}人收藏",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  )
                : Container()),
        SliverToBoxAdapter(
            child: Container(height: ScreenUtil().setHeight(100.0)))
      ]);
    });
  }
}
