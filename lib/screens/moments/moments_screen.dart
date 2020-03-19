import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neteast_cloud_music/api/CommonService.dart';
import 'package:neteast_cloud_music/model/event_content_model.dart';
import 'package:neteast_cloud_music/model/event_model.dart';
import 'package:neteast_cloud_music/utils/config.dart';
import 'package:neteast_cloud_music/utils/my_special_textspan_builder.dart';
import 'package:neteast_cloud_music/widgets/data_loading.dart';
import 'package:neteast_cloud_music/widgets/fade_network_image.dart';
import 'package:neteast_cloud_music/widgets/play_list_cover.dart';

class MomentsScreen extends StatefulWidget {
  @override
  _MomentsScreenState createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen> {
  int _code = Config.SUCCESS_CODE;
  List<Events> _event = [];

  List<Color> _data = [
    Colors.deepOrange,
    Colors.green,
    Colors.pinkAccent,
    Colors.blue,
    Colors.purple
  ];

  String _msg = "";

  Future _getEvent() {
    // type: 18 分享歌曲  24 分享专栏文章 13 分享歌单 39 发布视频
    return CommmonService().getEvent().then((res) {
      EventModel _bean = EventModel.fromJson(res.data);
      // EventContentModel _content =
      //     EventContentModel.fromJson(json.decode(_bean.event.first.json));
      if (_bean.code == _code) {
        return _bean;
      }
    });
  }

  String _formateArtist(List<Artists> _list) {
    String artists = '';
    for (var i = 0; i <= _list.length - 1; i++) {
      if (i == _list.length - 1) {
        artists = '$artists${_list[i].name}';
      } else {
        artists = '$artists${_list[i].name}\/';
      }
    }
    return artists;
  }

  Widget _defaultContent(
      {@required String url,
      @required String title,
      @required String subTitle,
      bool isSong = false}) {
    return Row(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(70.0),
          height: ScreenUtil().setWidth(70.0),
          margin: EdgeInsets.all(5.0),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                isSong
                    ? Container()
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        margin: EdgeInsets.only(right: 3.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                            border: Border.all(color: Colors.red)),
                        child: Text(
                          '歌单',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenUtil().setSp(18.0)),
                        ),
                      ),
                Container(
                  child: Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(28.0))),
                )
              ],
            ),
            Text(
              isSong ? subTitle : "by $subTitle",
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenUtil().setSp(20.0)),
            )
          ],
        )
      ],
    );
  }

  Widget _eventList(Events event) {
    EventContentModel _content =
        EventContentModel.fromJson(json.decode(event.json));
    Widget _picList;
    Widget _main;

    String _subTitle = "";

    switch (event.type) {
      case 13: //分享歌单
        _subTitle = "分享歌单";
        _main = _defaultContent(
            url: _content.playlist.coverImgUrl,
            title: _content.playlist.name,
            subTitle: _content.playlist.creator.nickname);
        break;
      case 18: //分享歌曲
        _subTitle = "分享歌曲";
        _main = _defaultContent(
            url: _content.song.album.blurPicUrl,
            title: _content.song.name,
            subTitle: _formateArtist(_content.song.artists),
            isSong: true);
        break;
      case 22: //转发
        _subTitle = "转发";
        break;
      case 24: //分享专栏文章
        _subTitle = "分享专栏文章";
        break;
      case 35: //分享内容
        // _subTitle = "分享歌单";
        break;
      case 39: //发布视频
        _subTitle = "发布视频";
        break;
      default:
    }

    String _eventTime = DateUtil.yearIsEqual(
            DateTime.fromMillisecondsSinceEpoch(event.eventTime),
            DateTime.now())
        ? DateUtil.isYesterday(
                DateTime.fromMillisecondsSinceEpoch(event.eventTime),
                DateTime.now())
            ? "昨天${DateUtil.formatDateMs(event.eventTime, format: DataFormats.zh_h_m)}"
            : "${DateUtil.formatDateMs(event.eventTime, format: 'M月dd日')}"
        : "${DateUtil.formatDateMs(event.eventTime, format: 'yyyy/M/d')}";

    switch (event.pics.length) {
      case 1:
        _picList = ExtendedImage.network(
          event.pics.first.originUrl,
          width: event.pics.first.width > event.pics.first.height
              ? ScreenUtil().setWidth(350)
              : ScreenUtil().setWidth(280),
          height: event.pics.first.width > event.pics.first.height
              ? ScreenUtil().setWidth(280)
              : ScreenUtil().setWidth(350),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        );
        break;
      case 4:
        _picList = Flow(
            delegate: MyFlowDelegate(boxSize: ScreenUtil().setWidth(180.0)),
            children: event.pics.map((urls) {
              return GestureDetector(
                onTap: () {
                  print("");
                },
                child: Container(
                  width: ScreenUtil().setWidth(180.0),
                  child: PlayListCoverWidget(
                    urls.squareUrl,
                    width: 180.0,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList());
        break;
      default:
        _picList = Wrap(
            spacing: 3.0,
            runSpacing: 3.0,
            children: event.pics.map((urls) {
              return GestureDetector(
                onTap: () {
                  print("");
                },
                child: Container(
                  width: ScreenUtil().setWidth(180.0),
                  child: PlayListCoverWidget(
                    urls.squareUrl,
                    width: 180.0,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList());
    }

    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
              alignment: Alignment.topRight,
              overflow: Overflow.visible,
              children: <Widget>[
                ClipOval(
                  child: FadeNetWorkImage(
                    event.user.avatarUrl,
                    fit: BoxFit.cover,
                    width: ScreenUtil().setWidth(70.0),
                  ),
                ),
                event.pendantData != null
                    ? Positioned(
                        top: -5.0,
                        right: -5.0,
                        child: FadeNetWorkImage(
                          event.pendantData.imageUrl,
                          width: ScreenUtil().setWidth(100.0),
                        ),
                      )
                    : Container()
              ]),
          SizedBox(width: ScreenUtil().setWidth(20.0)),
          Flexible(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Text(event.user.nickname,
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
                Container(
                  height: ScreenUtil().setHeight(80.0),
                  decoration: BoxDecoration(
                      color: Color(0xfff1f1f1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: _main,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      backgroundColor: Colors.white,
      body: EasyRefresh.custom(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        firstRefresh: true,
        firstRefreshWidget: Container(
            width: double.infinity,
            // height: double.infinity,
            child: DataLoading()),
        onRefresh: () async {
          EventModel eventList = await _getEvent();
          print(eventList.event.length);
          if (mounted) {
            _event = eventList.event;
          }
          setState(() {});
        },
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setWidth(130),
                  left: ScreenUtil().setWidth(40.0),
                  bottom: ScreenUtil().setWidth(40.0)),
              // height: ScreenUtil().setHeight(200.0),
              child: Row(
                children: _data.map((color) {
                  return Container(
                    width: ScreenUtil().setWidth(130.0),
                    padding:
                        EdgeInsets.only(right: ScreenUtil().setWidth(10.0)),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            ClipOval(
                              child: Container(
                                color: color,
                                width: ScreenUtil().setWidth(80.0),
                                height: ScreenUtil().setWidth(80.0),
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              child: Container(
                                width: ScreenUtil().setWidth(30.0),
                                height: ScreenUtil().setWidth(30.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Center(
                                  child: Text(
                                    "V",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(18.0)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10.0),
                        ),
                        Text(
                          '云村有票官方号',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(22.0),
                              color: Colors.black54),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(color: Colors.black54, height: 1.0),
          ),
          SliverPadding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(40.0)),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _eventList(_event[index]);
              }, childCount: _event.length),
            ),
          )
        ],
      ),
    );
  }
}

class MyFlowDelegate extends FlowDelegate {
  final double boxSize;
  MyFlowDelegate({@required this.boxSize});

  @override
  void paintChildren(FlowPaintingContext context) {
    /*屏幕宽度*/
    var screenW = context.size.width;

    double padding = 3.0; //间距
    double x = padding; //x坐标
    double y = padding; //y坐标

    int itemLength = 0;

    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x;
      if (w < context.size.width && itemLength < 2) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + padding;
        itemLength++;
      } else {
        x = padding;
        y += context.getChildSize(i).height + padding;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + padding;
        itemLength = 0;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
    double height = boxSize * 2 + 9.0;
    return Size(double.infinity + 10, height);
  }
}
