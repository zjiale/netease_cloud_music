import 'dart:ui';
import 'package:async/async.dart';
import 'package:color_thief_flutter/color_thief_flutter.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:wangyiyun/api/CommonService.dart';
import 'package:wangyiyun/model/play_list.detail.dart';
import 'package:wangyiyun/screens/playlist/play_list_bottom.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/utils/numbers_convert.dart';
import 'package:wangyiyun/widgets/flexible_detail_bar.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';

class PlayListScreen extends StatefulWidget {
  final double expandedHeight;
  final int pid;

  PlayListScreen(this.expandedHeight, this.pid);

  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  List _button = Config.button;
  int _code = Config.SUCCESS_CODE;

  bool _marquee = false;

  ScrollController _controller = new ScrollController();

  AsyncMemoizer _memoizer = AsyncMemoizer();

  Color bgColor;

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

  Future _initDetailPlayList() {
    return _memoizer.runOnce(() async {
      return CommmonService().getDetailPlayList(widget.pid).then((res) {
        if (res.statusCode == 200) {
          PlayListDetailModel _bean = PlayListDetailModel.fromJson(res.data);
          if (_bean.code == _code) {
            getColorFromUrl(_bean.playlist.coverImgUrl).then((color) {
              setState(() {
                bgColor = Color.fromRGBO(color[0], color[1], color[2], 1);
              }); // [R,G,B]
            });
            return _bean;
          }
        }
      });
    });
  }

  Widget playButton(int shareCount, int commentCount) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _button.asMap().entries.map((MapEntry map) {
          String _text;
          switch (map.key) {
            case 0:
              _text = commentCount != 0 ? '$commentCount' : '评论';
              break;
            case 1:
              _text = shareCount != 0 ? '$shareCount' : '分享';
              break;
            case 2:
              _text = '下载';
              break;
            case 3:
              _text = '多选';
              break;
          }
          return InkWell(
            onTap: () {
              print(map.key);
            },
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Image.asset(_button[map.key],
                  width: ScreenUtil().setWidth(40.0),
                  height: ScreenUtil().setWidth(40.0)),
              SizedBox(height: ScreenUtil().setHeight(5.0)),
              Text(_text)
            ]),
          );
        }).toList());
  }

  Widget content(PlayListDetailModel detail) {
    return CustomScrollView(controller: _controller, slivers: <Widget>[
      SliverAppBar(
          pinned: true,
          expandedHeight: ScreenUtil().setHeight(widget.expandedHeight),
          elevation: 0,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
          title: _marquee
              ? Container(
                  height: ScreenUtil().setHeight(80),
                  child: MarqueeWidget(
                    text: detail.playlist.name,
                    scrollAxis: Axis.horizontal,
                  ),
                )
              : Text('歌单'),
          flexibleSpace: FlexibleDetailBar(
              content: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(35),
                    right: ScreenUtil().setWidth(35),
                    top: ScreenUtil().setWidth(120),
                  ),
                  child: Column(children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          PlayListCoverWidget(detail.playlist.coverImgUrl,
                              width: 230,
                              playCount: NumberUtils.amountConversion(
                                  detail.playlist.playCount)),
                          SizedBox(width: ScreenUtil().setWidth(40.0)),
                          Expanded(
                              child: Container(
                            height: ScreenUtil().setWidth(230),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(detail.playlist.name,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(33.0),
                                          fontWeight: FontWeight.bold)),
                                  Row(children: <Widget>[
                                    ClipOval(
                                        child: Container(
                                      width: 20.0,
                                      height: 20.0,
                                      child: ExtendedImage.network(
                                          detail.playlist.creator.avatarUrl,
                                          fit: BoxFit.cover),
                                    )),
                                    SizedBox(
                                        width: ScreenUtil().setWidth(10.0)),
                                    Text(detail.playlist.creator.nickname,
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(25.0),
                                            color: Color(0xffcdcdcd))),
                                    Icon(Icons.keyboard_arrow_right,
                                        size: ScreenUtil().setSp(40.0),
                                        color: Color(0xffcdcdcd))
                                  ]),
                                  Text(detail.playlist.description,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(20.0),
                                          color: Color(0xffcdcdcd)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis)
                                ]),
                          ))
                        ]),
                    SizedBox(height: ScreenUtil().setHeight(30.0)),
                    playButton(detail.playlist.shareCount,
                        detail.playlist.commentCount)
                  ]),
                ),
              ),
              background: Stack(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: bgColor),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaY: 5,
                      sigmaX: 5,
                    ),
                    child: Container(
                      color: Colors.black26,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ],
              )),
          bottom: PlayListBottom(detail)),
      SliverPadding(
        padding: EdgeInsets.only(left: 10.0),
        sliver: SliverFixedExtentList(
          itemExtent: ScreenUtil().setHeight(100.0),
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(60.0),
                    child: Center(
                      child: Text('${index + 1}',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(30.0),
                              color: Colors.black45)),
                    ),
                  ),
                  Expanded(
                      child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    title: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: detail.playlist.tracks[index].name,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(28.0),
                                color: detail.privileges[index].st == -200
                                    ? Colors.grey
                                    : Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: detail.playlist.tracks[index].tns !=
                                          null
                                      ? '(${detail.playlist.tracks[index].tns.first})'
                                      : '',
                                  style: TextStyle(color: Color(0xffcdcdcd)))
                            ])),
                    subtitle: Text(
                        '${detail.playlist.tracks[index].ar.first.name} - ${detail.playlist.tracks[index].al.name}',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(20.0),
                            color: detail.privileges[index].st == -200
                                ? Colors.grey
                                : Colors.black54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  )),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  )
                ]);
          }, childCount: detail.playlist.trackCount),
        ),
      ),
      SliverToBoxAdapter(
          child: Container(height: ScreenUtil().setHeight(100.0))),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
        body: FutureBuilder(
            future: _initDetailPlayList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                      child: SpinKitChasingDots(
                          color: Theme.of(context).primaryColor, size: 30.0));
                case ConnectionState.done:
                  PlayListDetailModel playList = snapshot.data;
                  return content(playList);
                default:
                  return null;
              }
            }));
  }
}
