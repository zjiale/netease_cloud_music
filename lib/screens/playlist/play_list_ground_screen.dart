import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/screens/audio/mini_player.dart';
import 'package:netease_cloud_music/screens/playlist/other_sub_play_list.dart';
import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/store/model/play_song_model.dart';
import 'package:netease_cloud_music/widgets/fade_network_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

class PlayListGroundScreen extends StatefulWidget {
  final List tagList;
  PlayListGroundScreen({@required this.tagList});

  @override
  _PlayListGroundScreenState createState() => _PlayListGroundScreenState();
}

class _PlayListGroundScreenState extends State<PlayListGroundScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _tabIndex = 0;

  TabController _tabController;

  int _imageIndex = 0;
  List<String> _bgImage = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: widget.tagList.length)
      ..addListener(() {
        if (_tabController.index.toDouble() == _tabController.animation.value) {
          if (_tabIndex == _tabController.index) return;
          setState(() {
            _tabIndex = _tabController.index;
          });
        }
      });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _getImageIndex(index) {
    setState(() {
      _imageIndex = index;
    });
  }

  void _getBgImage(val) {
    setState(() {
      _bgImage = val;
    });
  }

  Widget content() {
    return extended.NestedScrollView(
      pinnedHeaderSliverHeightBuilder: () {
        return MediaQuery.of(context).padding.top + kToolbarHeight;
      },
      innerScrollPositionKeyBuilder: () {
        return Key("Tag${_tabController.index}");
      },
      headerSliverBuilder: (context, innerBoxIsScrolled) =>
          <Widget>[SliverToBoxAdapter()],
      body: TabBarView(
        // physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: widget.tagList.map((tag) {
          return OtherSubPlayList(
            tag: tag == "推荐" ? "" : tag,
            index: _tabIndex,
            indexCallback: (index) => _getImageIndex(index),
            imgCallback: (val) => _getBgImage(val),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
                height: ScreenUtil().setHeight(500.0),
                color: Colors.white,
                child: _bgImage.length > 0 && _tabIndex == 0
                    ? FadeNetWorkImage(_bgImage[_imageIndex])
                    : null),
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
                            onTap: (index) {
                              if (_tabIndex == index) return;
                              setState(() {
                                _tabIndex = index;
                              });
                            },
                            tabs: widget.tagList.map((tag) {
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
              body: Stack(
                children: <Widget>[
                  content(),
                  Positioned(
                      bottom: 0.0,
                      child: Store.connect<PlaySongModel>(
                          builder: (context, model, child) {
                        return Offstage(
                            offstage: model.show,
                            child: MiniPlayer(model: model));
                      }))
                ],
              ))
        ],
      ),
    );
  }
}
