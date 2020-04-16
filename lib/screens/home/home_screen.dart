import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/netease_cloud_music_route.dart' as prefix;
import 'package:netease_cloud_music/screens/audio/mini_player.dart';
import 'package:netease_cloud_music/screens/find/find_screen.dart';
import 'package:netease_cloud_music/screens/home/tab_title.dart';
import 'package:netease_cloud_music/screens/events/events_screen.dart';
import 'package:netease_cloud_music/screens/user_center/user_center_screen.dart';
import 'package:netease_cloud_music/screens/video/video_screen.dart';
import 'package:netease_cloud_music/store/index.dart';

import 'package:netease_cloud_music/store/model/play_song_model.dart';
import 'package:netease_cloud_music/store/model/play_video_model.dart';
import 'package:netease_cloud_music/utils/cache.dart';
import 'package:netease_cloud_music/utils/config.dart';

import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
    name: "neteasecloudmusic://homescreen",
    routeName: "HomeScreen",
    argumentNames: ["model"],
    pageRouteType: PageRouteType.transparent,
    description: "登录成功之后主页面，接收的model参数是用于判断视频播放状态")
class HomeScreen extends StatefulWidget {
  final PlayVideoModel model;
  HomeScreen({this.model});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<String> _title = Config.title;
  List<Widget> _pages;

  int _currentIndex;

  PageController _pageController;
  void Function(int) pageCall;

  ColorTween _colorTween; // 导航栏颜色
  double _offset = 1;

  //title设置回来的回调  当body页面变化时，会调用参数中的函数，将结果传递到title界面
  void _pageChagedCall(void Function(int) call) {
    this.pageCall = call;
  }

  //标题被点击时回调  滚动body页面
  void _tittleItemClickCall(int pos) {
    _pageController.animateToPage(pos,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void _pageChage(int pos) {
    if (pageCall != null) {
      setState(() {
        _currentIndex = pos;
      });
      pageCall(pos);
    }
    //判断当前页面位置，如果为动态页面则将inde何止为0，若不设置由动态切换回发现页面视频还是会继续播放
    if (pos != 2) {
      if (widget.model.index.value == -1) return;
      widget.model.changeIndex(-1);
    } else {
      widget.model.changeIndex(0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 1;
    _pages = List()
      ..add(UserCenterScreen())
      ..add(FindScreen())
      ..add(EventsScreen())
      ..add(VideoScreen());
    _pageController = PageController(initialPage: _currentIndex)
      ..addListener(() {
        setState(() {
          _offset = _pageController.offset / MediaQuery.of(context).size.width;
        });
      });
    _colorTween = ColorTween(
        begin: Colors.white, end: Colors.transparent); //根据偏移量来设置tabbar背景色
  }

  Widget _drawerContent() {
    return Material(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipPath(
                clipper: HeaderCustomClipper(),
                child: Container(
                  width: double.infinity,
                  height: 200.0,
                  color: Colors.orangeAccent,
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: ClipOval(
                  child: SizedBox(
                    height: 80.0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                              image: AssetImage('assets/creator.jpg'))),
                      width: 80.0,
                      height: 80.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 3.0,
              child: ListTile(
                leading: Icon(
                  Icons.http,
                  color: Colors.white,
                  size: 30.0,
                ),
                title: Text(
                  'GitHub',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'https://github.com/zjiale/',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
              color: Colors.lightGreen,
              elevation: 3.0,
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30.0,
                ),
                title: Text(
                  '姓名',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '朱嘉乐',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Card(
                color: Colors.pink,
                elevation: 3.0,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      title: Text(
                        '邮箱',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '514137975@qq.com',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      title: Text(
                        '电话',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '15602295985',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    )
                  ],
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
              elevation: 0.0,
              color: Colors.purple,
              child: ListTile(
                onTap: () {
                  SpUtil.preferences.clear();
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      prefix.Routes.NETEASECLOUDMUSIC_LOGINSCREEN,
                      (Route<dynamic> route) => false);
                },
                leading: Text(
                  '退出登录',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.keyboard_arrow_right,
                    size: 20.0, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle style = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              _currentIndex == 0 ? Brightness.light : Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(style);
    }

    return Scaffold(
        drawer: Drawer(child: _drawerContent()),
        body: Stack(children: <Widget>[
          PageView.builder(
              controller: _pageController,
              itemCount: _title.length,
              onPageChanged: _pageChage,
              itemBuilder: (context, pos) {
                return _pages[pos];
              }),
          Container(
            height: ScreenUtil().setHeight(80.0) +
                MediaQuery.of(context).padding.top,
            width: double.infinity,
            child: AppBar(
                brightness:
                    _currentIndex == 0 ? Brightness.dark : Brightness.light,
                backgroundColor: _colorTween.lerp(1 - _offset),
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.transparent),
                titleSpacing: 0.0,
                centerTitle: true,
                title: TabTitle(
                  _title,
                  setCall: _pageChagedCall,
                  itemClick: _tittleItemClickCall,
                ),
                leading: Builder(
                  builder: (context) => IconButton(
                      icon: Icon(Icons.menu,
                          color:
                              _currentIndex == 0 ? Colors.white : Colors.black),
                      onPressed: () => Scaffold.of(context).openDrawer()),
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.search,
                          color:
                              _currentIndex == 0 ? Colors.white : Colors.black),
                      onPressed: () => Navigator.pushNamed(context,
                          prefix.Routes.NETEASECLOUDMUSIC_SEARCHSCREEN))
                ]),
          ),
          Positioned(
              bottom: 0.0,
              child: Store.connect<PlaySongModel>(
                  builder: (context, model, child) {
                return Offstage(
                    offstage: model.show, child: MiniPlayer(model: model));
              }))
        ]));
  }
}

// 抽屉裁剪
class HeaderCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    Offset firstControlPoint = Offset(size.width / 4, size.height - 40);
    Offset firstPoint = Offset(size.width / 2, size.height - 40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    Offset secondControlPoint =
        Offset(size.width - (size.width / 4), size.height - 40);
    Offset secondPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
