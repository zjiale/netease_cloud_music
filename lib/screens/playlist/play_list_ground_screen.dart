import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:wangyiyun/api/CommonService.dart';
import 'package:wangyiyun/model/top_quality_play_list_model.dart';
import 'package:wangyiyun/screens/playlist/list_source_repository.dart';
import 'package:wangyiyun/screens/playlist/top_disc.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/utils/numbers_convert.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';

class PlayListGroundScreen extends StatefulWidget {
  @override
  _PlayListGroundScreenState createState() => _PlayListGroundScreenState();
}

class _PlayListGroundScreenState extends State<PlayListGroundScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _code = Config.SUCCESS_CODE;
  final List<String> myTabs = <String>[
    '推荐',
    // '官方',
    // '精品',
    '华语',
    'ACG',
    '流行',
    '摇滚',
    '电子'
  ];

  TabController _tabController;
  AnimationController _controller;
  ListSourceRepository listSourceRepository;

  Future _initData;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _initData = _getFirstTag();
  }

  @override
  void dispose() {
    listSourceRepository?.dispose();
    super.dispose();
  }

  Future _getFirstTag() {
    return CommmonService().getGroundPlayList(0).then((res) {
      if (res.statusCode == 200) {
        TopQualityPlayListModel _bean =
            TopQualityPlayListModel.fromJson(res.data);
        if (_bean.code == _code) {
          listSourceRepository = new ListSourceRepository(
              firstData: _bean.playlists.sublist(3), isInit: true);
          return _bean.playlists.sublist(0, 3);
        }
      }
    });
  }

  // 其他歌单
  Widget restList(BuildContext context, Playlists item, int index) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PlayListCoverWidget(item.coverImgUrl,
              width: 220,
              playCount: NumberUtils.amountConversion(item.playCount)),
          SizedBox(height: 5.0),
          Container(
              width: ScreenUtil().setWidth(200.0),
              child: Text(item.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: ScreenUtil().setSp(23.0))))
        ]);
  }

  Widget content() {
    return FutureBuilder(
        future: _initData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              _controller.reset();
              return Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    SpinKitWave(
                        color: Theme.of(context).primaryColor, size: 20.0),
                    SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      '正在努力加载中',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28.0),
                          color: Colors.black54),
                    )
                  ]));
            case ConnectionState.done:
              _controller.forward();
              List<Playlists> source = snapshot.data;
              return FadeTransition(
                opacity: _controller,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerScrolled) => <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    )
                  ],
                  body: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: myTabs.asMap().entries.map((MapEntry e) {
                      return Builder(
                        builder: (context) => e.key == 0
                            ? LoadingMoreCustomScrollView(
                                key: PageStorageKey<int>(e.key),
                                slivers: <Widget>[
                                  // SliverOverlapInjector(
                                  //     handle: NestedScrollView
                                  //         .sliverOverlapAbsorberHandleFor(context)),
                                  SliverToBoxAdapter(
                                    child: TopDisc(source: source),
                                  ),
                                  SliverPadding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            ScreenUtil().setWidth(20.0)),
                                    sliver: LoadingMoreSliverList(
                                      SliverListConfig<Playlists>(
                                        itemBuilder: restList,
                                        sourceList: listSourceRepository,
                                        padding: EdgeInsets.all(0.0),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 0.7,
                                          crossAxisSpacing:
                                              ScreenUtil().setWidth(20.0),
                                          // mainAxisSpacing: 10.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setWidth(20.0)),
                                child: LoadingMoreList(
                                  ListConfig<Playlists>(
                                    itemBuilder: restList,
                                    sourceList: ListSourceRepository(
                                        tag: myTabs[e.key]),
                                    padding: EdgeInsets.all(0.0),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.7,
                                      crossAxisSpacing:
                                          ScreenUtil().setWidth(20.0),
                                      // mainAxisSpacing: 10.0,
                                    ),
                                  ),
                                ),
                              ),
                      );
                    }).toList(),
                  ),
                ),
              );
            default:
              return null;
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(600.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: AssetImage('assets/timg.jpg'))),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 10,
                sigmaX: 10,
              ),
              child: Container(
                color: Colors.white.withOpacity(0.8),
                width: double.infinity,
                height: double.infinity,
              ),
            )
          ]),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black87),
                backgroundColor: Colors.transparent,
                titleSpacing: 0.0,
                elevation: 0.0,
                title: Text(
                  '歌单广场',
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(35.0)),
                ),
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(40.0),
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
                      child: Row(children: <Widget>[
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
                            tabs: myTabs.map((item) {
                              return Tab(
                                text: item,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10.0)),
                        Icon(Icons.menu)
                      ]),
                    )),
              ),
              body: NestedScrollView(
                  headerSliverBuilder: (context, innerScrolled) => <Widget>[
                        SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        )
                      ],
                  body: content()))
        ],
      ),
    );
  }
}
