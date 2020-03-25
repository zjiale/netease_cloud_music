import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neteast_cloud_music/api/CommonService.dart';
import 'package:neteast_cloud_music/model/event_content_model.dart';
import 'package:neteast_cloud_music/model/event_model.dart';
import 'package:neteast_cloud_music/model/follow_model.dart';
import 'package:neteast_cloud_music/screens/events/event_decription.dart';
import 'package:neteast_cloud_music/screens/events/event_detail_screen.dart';
import 'package:neteast_cloud_music/store/index.dart';
import 'package:neteast_cloud_music/store/model/play_song_model.dart';
import 'package:neteast_cloud_music/utils/config.dart';
import 'package:neteast_cloud_music/widgets/data_loading.dart';
import 'package:neteast_cloud_music/widgets/fade_network_image.dart';
import 'package:rect_getter/rect_getter.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with AutomaticKeepAliveClientMixin {
  int _code = Config.SUCCESS_CODE;
  int lastTime = 0;
  List<Events> _event = [];
  List<Follow> _followList = [];

  EasyRefreshController _controller = EasyRefreshController();

  final ValueNotifier<double> notifier = ValueNotifier(-1);

  var _keys = {};

  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _getFollows() {
    return CommmonService().getFollows().then((res) {
      FollowModel _bean = FollowModel.fromJson(res.data);
      if (_bean.code == _code) {
        return _bean.follow
            .sublist(0, _bean.follow.length < 5 ? _bean.follow.length : 5);
      }
    });
  }

  Future _getEvent({int lastTime = 0}) {
    // type: 18 分享歌曲  24 分享专栏文章 13 分享歌单 39 发布视频
    return CommmonService().getEvent(lasttime: lastTime).then((res) {
      EventModel _bean = EventModel.fromJson(res.data);
      if (_bean.code == _code) {
        return _bean;
      }
    });
  }

  Widget _follow() {
    return Container(
      padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(130), bottom: ScreenUtil().setWidth(40.0)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _followList.map((follower) {
              return Container(
                width: ScreenUtil().setWidth(130.0),
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(40.0),
                    right: ScreenUtil().setWidth(10.0)),
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
                          color: Colors.black54),
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
          Divider(color: Colors.black54, height: 1.0)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var _scrollViewKey = RectGetter.createGlobalKey();

    List<int> getVisible() {
      int _delete = 0;

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
                itemRect.bottom - kToolbarHeight < rect.top) &&
            _event[index].type == 39) _items.add(index);
      });

      if (_items.length > 1) {
        _items.forEach((index) {
          var itemRect = RectGetter.getRectFromKey(_keys[index]);
          if (itemRect.top < rect.bottom / 2 ||
              itemRect.bottom > rect.bottom - ScreenUtil().setHeight(80.0)) {
            _delete = index;
          }
        });
        _items.remove(_delete);
      }

      /// 这个集合中存的就是当前处于显示状态的所有item的index
      return _items;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          /// 滚动时实时打印当前可视条目的index
          print(getVisible());
          return true;
        },
        child: Store.connect<PlaySongModel>(builder: (context, model, child) {
          return EasyRefresh.custom(
            controller: _controller,
            header: MaterialHeader(),
            footer: MaterialFooter(),
            firstRefresh: true,
            firstRefreshWidget: Container(
                width: double.infinity,
                // height: double.infinity,
                child: DataLoading()),
            onRefresh: () async {
              EventModel eventList = await _getEvent();
              List<Follow> followList = await _getFollows();
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
              EventModel eventList = await _getEvent(lastTime: lastTime);
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
                    ScreenUtil().setWidth(40.0),
                    ScreenUtil().setWidth(20.0),
                    ScreenUtil().setWidth(40.0),
                    ScreenUtil().setWidth(40.0)),
                sliver: SliverList(
                  key: _scrollViewKey,
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => EventDetailScreen(
                          //             event: _event[index])));
                        },
                        child: EventDescription(
                            event: _event[index],
                            model: model,
                            notifier: notifier,
                            index: index,
                            callback: (val) => _keys.addAll(val)));
                  }, childCount: _event.length),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
