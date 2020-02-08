import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/screens/user_center/networking_page_header.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/widgets/flexible_detail_bar.dart';
import 'package:wangyiyun/widgets/space_bar.dart';
import 'package:wangyiyun/widgets/user_center_list.dart';

class UserCenterScreen extends StatefulWidget {
  @override
  _UserCenterScreenState createState() => _UserCenterScreenState();
}

class _UserCenterScreenState extends State<UserCenterScreen> {
  List _button = Config.centerBtn;
  int _selectIndex = 0;

  Widget centerButton() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _button.asMap().entries.map((MapEntry map) {
          return InkWell(
            onTap: () {
              print(map.key);
            },
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Image.asset(_button[map.key]['image'],
                  width: ScreenUtil().setWidth(80.0),
                  height: ScreenUtil().setWidth(80.0),
                  color: Colors.white),
              // SizedBox(height: ScreenUtil().setHeight(5.0)),
              Text(_button[map.key]['text'],
                  style: TextStyle(fontSize: ScreenUtil().setSp(25.0)))
            ]),
          );
        }).toList());
  }

  Widget option(int create, int collect) {
    List<String> _options = ["创建歌单", "收藏歌单"];
    return Row(
        children: _options.asMap().entries.map((MapEntry map) {
      return Row(children: <Widget>[
        GestureDetector(
            onTap: () {
              setState(() {
                _selectIndex = map.key;
              });
            },
            child: RichText(
                text: TextSpan(
                    text: _options[map.key],
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(30.0),
                        fontWeight: FontWeight.bold,
                        color: _selectIndex == map.key
                            ? Colors.black
                            : Colors.grey),
                    children: <TextSpan>[
                  TextSpan(
                      text: map.key == 0 ? '$create' : '$collect',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(20.0),
                          color: _selectIndex == map.key
                              ? Colors.black
                              : Colors.grey))
                ]))),
        SizedBox(width: ScreenUtil().setWidth(30.0)),
      ]);
    }).toList());
  }

  List<Widget> playList(int index) {
    int _length;
    switch (index) {
      case 0:
        _length = 4;
        break;
      case 1:
        _length = 10;
        break;
    }
    List<Widget> _list = [];
    for (int i = 0; i < _length; i++) {
      _list.add(UserCenterList('歌单：粤语传世经典，怀旧是人的本能', subTitle: '继续播放'));
    }
    if (index == 0) {
      _list.add(UserCenterList('创建歌单', create: true));
    }

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: NetworkingPageHeader(
              maxExtent: ScreenUtil().setHeight(380),
              minExtent: ScreenUtil().setHeight(40)),
        ),
        SliverToBoxAdapter(
            child: Container(
                height: ScreenUtil().setHeight(50.0),
                padding: EdgeInsets.only(left: 20.0),
                child: Text('我的音乐',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(30.0),
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.white, width: 0.0))))),
        SliverPadding(
            padding: EdgeInsets.only(left: 20.0),
            sliver: SliverToBoxAdapter(
                child: Container(
                    height: ScreenUtil().setHeight(250.0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: ScreenUtil().setHeight(250.0),
                            margin: EdgeInsets.only(right: 10.0),
                            width: (MediaQuery.of(context).size.width - 60) / 3,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                          );
                        })))),
        SliverToBoxAdapter(
            child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(50.0)),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('最近播放',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(30.0),
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('更多',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(25.0),
                                      color: Color(0xffcdcdcd))),
                              Icon(Icons.keyboard_arrow_right,
                                  size: ScreenUtil().setSp(50.0),
                                  color: Color(0xffcdcdcd))
                            ])
                      ]),
                  SizedBox(height: ScreenUtil().setHeight(15.0)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        UserCenterList('歌单：粤语传世经典，怀旧是人的本能', subTitle: '继续播放'),
                        UserCenterList('歌单：粤语传世经典，怀旧是人的本能', subTitle: '继续播放')
                      ])
                ]))),
        SliverToBoxAdapter(
            child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(50.0)),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            option(4, 10),
                            Icon(Icons.more_vert,
                                size: ScreenUtil().setSp(50.0),
                                color: Color(0xffcdcdcd))
                          ]),
                      SizedBox(height: ScreenUtil().setHeight(20.0)),
                      Wrap(
                        spacing: 20.0,
                        runSpacing: ScreenUtil().setHeight(20.0),
                        children: playList(_selectIndex),
                      )
                    ]))),
        SliverToBoxAdapter(
            child: Container(height: ScreenUtil().setHeight(100.0))),
      ],
    );
  }
}
