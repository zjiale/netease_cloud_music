import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/widgets/reorder_list.dart';

class PlayListGroundScreen extends StatefulWidget {
  @override
  _PlayListGroundScreenState createState() => _PlayListGroundScreenState();
}

class _PlayListGroundScreenState extends State<PlayListGroundScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<WReorderListState> _key = new GlobalKey<WReorderListState>();
  final List<Tab> myTabs = <Tab>[
    Tab(text: '推荐'),
    Tab(text: '官方'),
    Tab(text: '精品'),
    Tab(text: '华语'),
    Tab(text: 'ACG'),
    Tab(text: '流行'),
    Tab(text: '摇滚'),
    Tab(text: '电子'),
  ];

  final List<Color> _data = [Colors.blue, Colors.pinkAccent, Colors.deepPurple];

  TabController _tabController;

  double pageOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Stack(children: <Widget>[
          Container(
            height: 400.0,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/timg.jpg'))),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 20,
              sigmaX: 20,
            ),
            child: Container(
              color: Colors.white70,
              width: double.infinity,
              height: double.infinity,
            ),
          )
        ]),
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _key.currentState.swap(0, 1, 2);
            },
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black87),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            titleSpacing: 0.0,
            title: Text(
              '歌单广场',
              style: TextStyle(
                  color: Colors.black, fontSize: ScreenUtil().setSp(35.0)),
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
                  child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: TabBar(
                            isScrollable: true,
                            controller: _tabController,
                            labelPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor: Colors.black54,
                            indicatorColor: Theme.of(context).primaryColor,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: myTabs,
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10.0)),
                        Icon(Icons.menu)
                      ]),
                )),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: myTabs.asMap().entries.map((MapEntry e) {
              return e.key == 0
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100.0,
                        ),
                        Container(
                          height: 200.0,
                          // width: 200.0,
                          child: WReorderList(
                              key: _key,
                              children: _data
                                  .asMap()
                                  .entries
                                  .map((MapEntry s) => Container(
                                        height: 180.0,
                                        width: 130.0,
                                        margin: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: _data[s.key],
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        child: Center(
                                          child: Text('${s.key + 1}'),
                                        ),
                                      ))
                                  .toList(),
                              onIndexChanged: (a, b, c) {
                                setState(() {
                                  var temp = _data[a];
                                  _data[a] = _data[c];
                                  _data[c] = _data[b];
                                  _data[b] = temp;
                                });
                              }),
                        )
                      ],
                    )
                  : Container();
            }).toList(),
          ),
        ),
      ],
    );
  }
}
