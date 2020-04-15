import 'dart:ui';
import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/play_list_model.dart';
import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/store/model/user_model.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:netease_cloud_music/utils/routes/navigator_util.dart';
import 'package:netease_cloud_music/widgets/fade_network_image.dart';
import 'package:netease_cloud_music/widgets/flexible_detail_bar.dart';
import 'package:netease_cloud_music/widgets/space_bar.dart';
import 'package:netease_cloud_music/widgets/user_center_area.dart';
import 'package:netease_cloud_music/widgets/user_center_list.dart';

class UserCenterScreen extends StatefulWidget {
  @override
  _UserCenterScreenState createState() => _UserCenterScreenState();
}

class _UserCenterScreenState extends State<UserCenterScreen> {
  int _selectIndex = 0;
  List _button = Config.centerBtn;
  List _area = Config.centerArea;

  CommmonService api = CommmonService();

  AsyncMemoizer _memoizer = AsyncMemoizer();

  Future _initPlayList(int id) {
    return _memoizer.runOnce(() async {
      return api.getPlayList(id);
    });
  }

  Widget _centerButton() {
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

  Widget _option(int create, int collect) {
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

  List<Widget> _playList(int index, List create, List collect) {
    int _length;
    switch (index) {
      case 0:
        _length = create.length;
        break;
      case 1:
        _length = collect.length;
        break;
      default:
    }

    List<Widget> _list = [];
    for (int i = 0; i < _length; i++) {
      _list.add(GestureDetector(
        onTap: () => NavigatorUtil.goPlayListDetailPage(context,
            expandedHeight: 520, id: index == 0 ? create[i].id : collect[i].id),
        child: UserCenterList(index == 0 ? create[i].name : collect[i].name,
            subTitle:
                '${index == 0 ? create[i].trackCount : collect[i].trackCount}首',
            url: index == 0 ? create[i].coverImgUrl : collect[i].coverImgUrl),
      ));
    }
    if (_selectIndex == 0) {
      _list.add(UserCenterList('创建歌单', create: true));
    }

    return _list;
  }

  Widget _userCenter(
      List subscribedList, List unSubscribedList, UserModel userModel) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            pinned: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.transparent),
            expandedHeight: ScreenUtil().setHeight(350.0) +
                MediaQuery.of(context).padding.top,
            brightness: Brightness.dark,
            flexibleSpace: FlexibleDetailBar(
                content: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(35),
                      right: ScreenUtil().setWidth(35),
                      top: ScreenUtil().setWidth(130),
                    ),
                    child: Column(children: <Widget>[
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipOval(
                                child: FadeNetWorkImage(
                              userModel.user.profile.avatarUrl,
                              fit: BoxFit.cover,
                              width: ScreenUtil().setWidth(100.0),
                            )),
                            SizedBox(width: ScreenUtil().setWidth(15.0)),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(userModel.user.profile.nickname,
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(25.0),
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height: ScreenUtil().setHeight(10.0)),
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenUtil().setWidth(30.0))),
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 3.0),
                                        color: Colors.black38,
                                        child: Text('Lv.7',
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(20.0),
                                                color: Colors.white))),
                                  )
                                ])
                          ]),
                      SizedBox(height: ScreenUtil().setHeight(30.0)),
                      _centerButton()
                    ]),
                  ),
                ),
                background: Image.asset('assets/timg.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.srcOver,
                    color: Colors.black54)),
            bottom: SpaceBar()),
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
                    border: Border.all(width: 0, color: Colors.white)))),
        SliverPadding(
            padding: EdgeInsets.only(left: 20.0),
            sliver: SliverToBoxAdapter(
                child: Container(
                    height: ScreenUtil().setHeight(250.0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return UserCenterArea(_area[index], index);
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
                        UserCenterList('全部已播歌曲', subTitle: '300首', play: true),
                        UserCenterList('歌单：粤语传世经典，怀旧是人的本能',
                            subTitle: '继续播放', play: true)
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
                            _option(
                                unSubscribedList.length, subscribedList.length),
                            Icon(Icons.more_vert,
                                size: ScreenUtil().setSp(50.0),
                                color: Color(0xffcdcdcd))
                          ]),
                      SizedBox(height: ScreenUtil().setHeight(20.0)),
                      Wrap(
                        spacing: ScreenUtil().setWidth(30.0),
                        runSpacing: ScreenUtil().setHeight(20.0),
                        children: _playList(
                            _selectIndex, unSubscribedList, subscribedList),
                      )
                    ]))),
        SliverToBoxAdapter(
            child: Container(height: ScreenUtil().setHeight(100.0))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Store.connect<UserModel>(builder: (context, userModel, child) {
        return FutureBuilder(
          future: _initPlayList(userModel.user.profile.userId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: SpinKitChasingDots(
                        color: Theme.of(context).primaryColor, size: 30.0));
              case ConnectionState.done:
                // List loveList = snapshot.data;
                List subscribedList = List.from(snapshot.data);
                List unSubscribedList = List.from(snapshot.data);
                subscribedList.retainWhere((item) => item.subscribed == true);
                unSubscribedList.retainWhere((item) =>
                    item.subscribed == false && item.specialType != 5);

                return _userCenter(subscribedList, unSubscribedList, userModel);

              default:
                return null;
            }
          },
        );
      }),
    );
  }
}
