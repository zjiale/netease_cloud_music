import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:wangyiyun/api/CommonService.dart';
import 'package:wangyiyun/model/top_quality_play_list_model.dart';
import 'package:wangyiyun/screens/playlist/list_source_repository.dart';
import 'package:wangyiyun/screens/playlist/top_disc.dart';
import 'package:wangyiyun/store/model/tag_model.dart';
import 'package:wangyiyun/utils/config.dart';
import 'package:wangyiyun/utils/numbers_convert.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

class PlayListGroundScreen extends StatefulWidget {
  final TagModel tagModel;
  PlayListGroundScreen({@required this.tagModel});

  @override
  _PlayListGroundScreenState createState() => _PlayListGroundScreenState();
}

class _PlayListGroundScreenState extends State<PlayListGroundScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _code = Config.SUCCESS_CODE;

  TabController _tabController;
  AnimationController _controller;
  ListSourceRepository listSourceRepository;

  Future _initData;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(vsync: this, length: widget.tagModel.allTags.length);
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
              firstData: _bean.playlists.sublist(3),
              total: _bean.total - 3,
              isInit: true);
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

  Widget _buildIndicator(BuildContext context, IndicatorStatus status) {
    bool isSliver = _tabController.index == 0 ? true : false;

    Widget widget;
    switch (status) {
      case IndicatorStatus.none:
        widget = Container(height: 0.0);
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget =
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          SpinKitWave(color: Theme.of(context).primaryColor, size: 20.0),
          SizedBox(
            width: 5.0,
          ),
          Text(
            '正在努力加载中..',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(25.0), color: Colors.black54),
          )
        ]);
        widget =
            _setbackground(false, widget, height: ScreenUtil().setHeight(50.0));
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = _setbackground(true, widget);
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {}
        break;
      case IndicatorStatus.noMoreLoad:
        widget = Text('到底啦~',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(25.0), color: Colors.black54));
        widget =
            _setbackground(false, widget, height: ScreenUtil().setHeight(50.0));
        break;
      default:
    }
    return widget;
  }

  Widget _setbackground(bool full, Widget widget, {double height}) {
    widget = Container(
        width: double.infinity,
        height: height,
        child: widget,
        color: Colors.transparent,
        alignment: Alignment.center);
    return widget;
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
                          fontSize: ScreenUtil().setSp(25.0),
                          color: Colors.black54),
                    )
                  ]));
            case ConnectionState.done:
              _controller.forward();
              List<Playlists> source = snapshot.data;
              return FadeTransition(
                opacity: _controller,
                child: extended.NestedScrollView(
                  pinnedHeaderSliverHeightBuilder: () {
                    return MediaQuery.of(context).padding.top + kToolbarHeight;
                  },
                  innerScrollPositionKeyBuilder: () {
                    var index = "Tab";
                    index += _tabController.index.toString();
                    return Key(index);
                  },
                  headerSliverBuilder: (context, innerBoxIsScrolled) =>
                      <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    )
                  ],
                  body: IndexedStack(
                    index: _tabController.index,
                    children: widget.tagModel.allTags.map((tag) {
                      return extended
                          .NestedScrollViewInnerScrollPositionKeyWidget(
                              Key("Tab${_tabController.index}"),
                              EasyRefresh(
                                child: _tabController.index == 0
                                    ? CustomScrollView(
                                        key: PageStorageKey<String>(tag),
                                        slivers: <Widget>[
                                          // SliverOverlapInjector(
                                          //     handle: NestedScrollView
                                          //         .sliverOverlapAbsorberHandleFor(context)),
                                          SliverToBoxAdapter(
                                            child: TopDisc(source: source),
                                          ),
                                          SliverPadding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: ScreenUtil()
                                                    .setWidth(20.0)),
                                            sliver: GridView.builder(
                                              padding: EdgeInsets.all(0.0),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 0.7,
                                                crossAxisSpacing:
                                                    ScreenUtil().setWidth(20.0),
                                                // mainAxisSpacing: 10.0,
                                              ),
                                              itemCount: ,
                                              itemBuilder: restList(context, item, index),
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                              ));
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
              height: ScreenUtil().setHeight(500.0),
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
                color: Colors.white.withOpacity(0.8),
                width: double.infinity,
                height: ScreenUtil().setHeight(600.0),
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
                            tabs: widget.tagModel.allTags.map((tag) {
                              return Tab(
                                text: tag,
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
