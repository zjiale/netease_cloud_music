import 'package:flutter/material.dart';
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
  List<String> _title = Config.title;
  List<Widget> _pages;

  int _currentIndex;

  PageController _pageController;
  void Function(int) pageCall;

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
      pageCall(pos);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 1;
    _pages = List()..add(UserCenterScreen())..add(Find());
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // drawer: Drawer(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              //因为tittle准备放置一个listview，设置这个属性title横向填满
              titleSpacing: 0.0,
              centerTitle: true,
              title: TabTitle(
                _title,
                setCall: _pageChagedCall,
                itemClick: _tittleItemClickCall,
              ),
            ),
            body: PageView.builder(
                controller: _pageController,
                itemCount: _title.length,
                onPageChanged: _pageChage,
                itemBuilder: (context, pos) {
                  return _pages[pos];
                })));
  }
}
