import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/event_model.dart';
import 'package:netease_cloud_music/model/follow_model.dart';
import 'package:netease_cloud_music/netease_cloud_music_route.dart' as prefix;
import 'package:netease_cloud_music/screens/events/event_decription.dart';
import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/store/model/play_song_model.dart';
import 'package:netease_cloud_music/store/model/play_video_model.dart';
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:netease_cloud_music/widgets/fade_network_image.dart';
import 'package:rect_getter/rect_getter.dart';

@FFRoute(
    name: "neteasecloudmusic://eventscreen",
    routeName: "EventScreen",
    pageRouteType: PageRouteType.material,
    description: "云村动态界面,用于查看用户动态")
class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with AutomaticKeepAliveClientMixin {
  CommmonService api = CommmonService();
  int lastTime = 0;
  List<Events> _event = [];
  List<Follow> _followList = [];

  EasyRefreshController _controller = EasyRefreshController();

  var _keys = {};
  var _scrollViewKey = RectGetter.createGlobalKey();

  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<int> getVisible() {
    /// 先获取整个ListView的rect信息，然后遍历map
    /// 利用map中的key获取每个item的rect,如果该rect与ListView的rect存在交集
    /// 则将对应的index加入到返回的index集合中
    var rect = RectGetter.getRectFromKey(_scrollViewKey);
    var _items = <int>[];
    _keys.forEach((index, key) {
      var itemRect = RectGetter.getRectFromKey(key);

      /// 判断是否有视频进入视窗
      /// 当整个视频显示出来的时候才会加入进items中
      if (itemRect != null &&
          !(itemRect.top > rect.bottom - itemRect.size.height ||
              itemRect.bottom <
                  kToolbarHeight +
                      MediaQuery.of(context).padding.top +
                      (itemRect.size.height / 2)) &&
          _event[index].type == 39) _items.add(index);
    });

    /// 当视窗内有多个视频则移除第一个播放器只保留一个
    if (_items.length > 1) _items.removeAt(0);

    /// 这个集合中存的就是当前处于显示状态的所有item的index
    return _items;
  }

  Widget _follow() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFfbab66), Color(0xFFf7418c)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0))),
      padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(130) + MediaQuery.of(context).padding.top,
          bottom: ScreenUtil().setWidth(40.0)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _followList.map((follower) {
              return Container(
                width: ScreenUtil().setWidth(150.0),
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      overflow: Overflow.visible,
                      children: <Widget>[
                        ClipOval(
                          child: FadeNetWorkImage(
                            follower.avatarUrl,
                            width: ScreenUtil().setWidth(80.0),
                            fit: BoxFit.cover,
                          ),
                        ),
                        follower.vipRights != null &&
                                follower.vipRights.redVipAnnualCount == 1
                            ? Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                child: Container(
                                  width: ScreenUtil().setWidth(30.0),
                                  height: ScreenUtil().setWidth(30.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "V",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(18.0)),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10.0),
                    ),
                    Text(
                      follower.nickname,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(22.0),
                          color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Store.connect2<PlaySongModel, PlayVideoModel>(
          builder: (context, songModel, videoModel, child) {
        return NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) {
              if (getVisible().length > 0) {
                /// 滚动时实时打印当前可视条目的index
                if (videoModel.index != getVisible().first) {
                  videoModel.changeIndex(getVisible().first);
                }
              } else {
                if (notification.metrics.pixels <= 0) {
                  videoModel.resetIndex();
                } else {
                  videoModel.resetIndex(resetIndex: -1);
                }
              }
              return true;
            },
            child: EasyRefresh.custom(
              controller: _controller,
              header: MaterialHeader(),
              footer: MaterialFooter(),
              firstRefresh: true,
              firstRefreshWidget: Container(
                  width: double.infinity,
                  // height: double.infinity,
                  child: DataLoading()),
              onRefresh: () async {
                EventModel eventList = await api.getEvent();
                List<Follow> followList = await api.getFollows();
                if (eventList.more) lastTime = eventList.lasttime;

                eventList.event.removeWhere((event) => event.type == 33);

                if (mounted) {
                  _event = eventList.event;
                  _followList = followList;
                }

                setState(() {});
                _controller.finishLoad(noMore: !eventList.more);
              },
              onLoad: () async {
                EventModel eventList = await api.getEvent(lasttime: lastTime);
                if (eventList.more) lastTime = eventList.lasttime;
                if (mounted) {
                  _event.addAll(eventList.event);
                }
                setState(() {});
                _controller.finishLoad(noMore: !eventList.more);
              },
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: _follow(),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(20.0),
                      ScreenUtil().setWidth(20.0),
                      ScreenUtil().setWidth(40.0),
                      ScreenUtil().setWidth(40.0)),
                  sliver: SliverList(
                    key: _scrollViewKey,
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context,
                                prefix
                                    .Routes.NETEASECLOUDMUSIC_EVENTDETAILSCREEN,
                                arguments: {"event": _event[index]});
                          },
                          child: EventDescription(
                              event: _event[index],
                              model: songModel,
                              index: index,
                              callback: (val) => _keys.addAll(val)));
                    }, childCount: _event.length),
                  ),
                )
              ],
            ));
      }),
    );
  }
}
