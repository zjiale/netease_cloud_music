import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:wangyiyun/screens/playlist/play_list_bottom.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/widgets/flexible_detail_bar.dart';

class PlayListScreen extends StatefulWidget {
  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  List _button = Config.button;
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

  Widget playButton() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _button.asMap().entries.map((MapEntry map) {
          String _text;
          switch (map.key) {
            case 0:
              _text = '12356';
              break;
            case 1:
              _text = '321';
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
                  width: ScreenUtil().setWidth(45.0),
                  height: ScreenUtil().setWidth(45.0)),
              SizedBox(height: ScreenUtil().setHeight(5.0)),
              Text(_text)
            ]),
          );
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: <Widget>[
          SliverAppBar(
              pinned: true,
              expandedHeight: ScreenUtil().setHeight(530),
              elevation: 0,
              brightness: Brightness.dark,
              iconTheme: IconThemeData(color: Colors.white),
              title: _marquee
                  ? Container(
                      height: ScreenUtil().setHeight(80),
                      child: MarqueeWidget(
                        text: "粤语传世经典，怀旧是人的本能",
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
                              Container(
                                width: ScreenUtil().setWidth(230.0),
                                height: ScreenUtil().setWidth(230.0),
                                color: Colors.blue,
                              ),
                              SizedBox(width: ScreenUtil().setWidth(40.0)),
                              Expanded(
                                  child: Container(
                                height: ScreenUtil().setWidth(230),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('粤语传世经典，怀旧是人的本能',
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenUtil().setSp(33.0),
                                              fontWeight: FontWeight.bold)),
                                      Row(children: <Widget>[
                                        ClipOval(
                                            child: Container(
                                          color: Colors.yellow,
                                          width: 20.0,
                                          height: 20.0,
                                        )),
                                        SizedBox(
                                            width: ScreenUtil().setWidth(10.0)),
                                        Text('橘子树风车',
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(25.0),
                                                color: Color(0xffcdcdcd))),
                                        Icon(Icons.keyboard_arrow_right,
                                            size: ScreenUtil().setSp(40.0),
                                            color: Color(0xffcdcdcd))
                                      ]),
                                      Text('封面： 叶倩文&张国荣',
                                          style: TextStyle(
                                              fontSize:
                                                  ScreenUtil().setSp(20.0),
                                              color: Color(0xffcdcdcd)))
                                    ]),
                              ))
                            ]),
                        SizedBox(height: ScreenUtil().setHeight(30.0)),
                        playButton()
                      ]),
                    ),
                  ),
                  background: Stack(
                    children: <Widget>[
                      Image.asset(
                        'assets/timg.jpg',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaY: 5,
                          sigmaX: 5,
                        ),
                        child: Container(
                          color: Colors.black38,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ],
                  )),
              bottom: PlayListBottom()),
          SliverPadding(
            padding: EdgeInsets.only(left: 20.0),
            sliver: SliverFixedExtentList(
              itemExtent: ScreenUtil().setHeight(100.0),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('${index + 1}',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(30.0),
                              color: Colors.black45)),
                      Expanded(
                          child: ListTile(
                        title: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                text: 'We are the light',
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '(日剧《濑户内海》主题曲主题曲主题曲主题曲主题曲主题曲主题曲)',
                                      style:
                                          TextStyle(color: Color(0xffcdcdcd)))
                                ])),
                        subtitle: Text(
                            'aaaasdasdasdasdassssssssssssssdasdsadaaaaaaaaaaaaasadasdasdasdasdasdas',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      )),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {},
                      )
                    ]);
              }, childCount: 49),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(height: ScreenUtil().setHeight(100.0))),
        ],
      ),
    );
  }
}
