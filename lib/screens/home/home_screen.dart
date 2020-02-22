import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/screens/audio/audio_player_screen.dart';
import 'package:wangyiyun/screens/home/find.dart';
import 'package:wangyiyun/screens/home/tab_title.dart';
import 'package:wangyiyun/screens/user_center/user_center_screen.dart';
import 'package:wangyiyun/utils/config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Duration _duration = Duration(milliseconds: 200);

  List<String> _title = Config.title;
  List<Widget> _pages;

  int _currentIndex;

  PageController _pageController;
  void Function(int) pageCall;

  ColorTween _colorTween;
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 1;
    _pages = List()..add(UserCenterScreen())..add(Find());
    _pageController = PageController(initialPage: _currentIndex)
      ..addListener(() {
        setState(() {
          _offset = _pageController.offset / MediaQuery.of(context).size.width;
        });
      });
    _colorTween = ColorTween(
        begin: Colors.white, end: Colors.transparent); //根据偏移量来设置tabbar背景色
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            drawer: new Drawer(),
            body: Stack(children: <Widget>[
              PageView.builder(
                  controller: _pageController,
                  itemCount: _title.length,
                  onPageChanged: _pageChage,
                  itemBuilder: (context, pos) {
                    return _pages[pos];
                  }),
              Container(
                height: ScreenUtil().setHeight(80.0),
                width: double.infinity,
                child: AppBar(
                    backgroundColor: _colorTween.lerp(1 - _offset),
                    elevation: 0,
                    //因为tittle准备放置一个listview，设置这个属性title横向填满
                    titleSpacing: 0.0,
                    centerTitle: true,
                    title: TabTitle(
                      _title,
                      setCall: _pageChagedCall,
                      itemClick: _tittleItemClickCall,
                    ),
                    leading: GestureDetector(
                        onTap: () {
                          if (_scaffoldKey.currentState.isDrawerOpen) {
                            _scaffoldKey.currentState.openEndDrawer();
                          } else {
                            _scaffoldKey.currentState.openDrawer();
                          }
                        },
                        child: IconButton(
                            icon: Icon(Icons.menu,
                                color: _currentIndex == 0
                                    ? Colors.transparent
                                    : Colors.black))),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.search, color: Colors.black),
                          onPressed: () {})
                    ]),
              ),
              Positioned(
                  bottom: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AudioPlayerScreen()));
                    },
                    child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        height: ScreenUtil().setHeight(80.0),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white.withOpacity(0.9),
                        child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipOval(
                                  child: Container(
                                      width: ScreenUtil().setWidth(60.0),
                                      height: ScreenUtil().setWidth(60.0),
                                      color: Colors.orange)),
                              SizedBox(width: ScreenUtil().setWidth(10.0)),
                              Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                    Text(
                                      'asdadasdsadddddddddddddddddddddasdasdsadasdasdasdasdadsadadasdasdasdasdsa',
                                      maxLines: 1,
                                    ),
                                    Text('aaaa')
                                  ])),
                              IconButton(
                                  icon: Icon(Icons.play_circle_outline,
                                      size: ScreenUtil().setWidth(60.0),
                                      color: Colors.black54),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.list,
                                      size: ScreenUtil().setWidth(60.0),
                                      color: Colors.black54),
                                  onPressed: () {}),
                            ])),
                  ))
            ])));
  }
}
