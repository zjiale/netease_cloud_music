import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/api/CommonService.dart';
import 'package:netease_cloud_music/model/comment_list_model.dart';
import 'package:netease_cloud_music/model/comment_model.dart';
import 'package:netease_cloud_music/model/event_model.dart';
import 'package:netease_cloud_music/screens/events/event_decription.dart';
import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/store/model/play_song_model.dart';
import 'package:netease_cloud_music/store/model/play_video_model.dart';
import 'package:netease_cloud_music/utils/config.dart';
import 'package:netease_cloud_music/widgets/comment_item.dart';
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:rect_getter/rect_getter.dart';

class EventDetailScreen extends StatefulWidget {
  final Events event;
  final int index;
  EventDetailScreen({@required this.event, this.index});

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  int _code = Config.SUCCESS_CODE;
  List<CommentListModel> _hotComments = [];
  List<CommentListModel> _comments = [];
  String hotTitle = "";
  String title = "";

  bool isInit = false;

  int _pageIndex = 0;

  GlobalKey _itemKey;

  EasyRefreshController _controller = EasyRefreshController();

  Future _getEventComment({int offset = 0}) {
    return CommmonService()
        .getEventComment(widget.event.info.threadId, offset: offset)
        .then((res) {
      if (res.statusCode == 200) {
        CommentModel _bean = CommentModel.fromJson(res.data);
        if (_bean.code == _code) {
          return _bean;
        }
      }
    });
  }

  List<CommentListModel> addToModel(List comments) {
    List<CommentListModel> _list = [];
    comments.forEach((comment) {
      if (comment.parentCommentId != 0) return;
      _list.add(CommentListModel(
          nickname: comment.user.nickname,
          id: comment.user.userId,
          avatarUrl: comment.user.avatarUrl,
          pendantDataUrl:
              comment.pendantData != null ? comment.pendantData.imageUrl : null,
          content: comment.content,
          time: comment.time,
          likedCount: comment.likedCount,
          liked: comment.liked));
    });
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white,
          titleSpacing: 0.0,
          elevation: 0.0,
          title: Text(
            '动态',
            style: TextStyle(
                color: Colors.black, fontSize: ScreenUtil().setSp(35.0)),
          ),
        ),
        body: Store.connect2<PlaySongModel, PlayVideoModel>(
            builder: (context, songModel, videoModel, child) {
          return NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) {
              Rect _itemRect = RectGetter.getRectFromKey(_itemKey);
              if (_itemRect.top + (_itemRect.size.height / 2) <
                  kToolbarHeight + MediaQuery.of(context).padding.top) {
                videoModel.stopPlay();
              } else {
                videoModel.startPlay();
              }
              return true;
            },
            child: EasyRefresh.custom(
              controller: _controller,
              topBouncing: isInit ? false : true,
              footer: MaterialFooter(),
              firstRefresh: true,
              firstRefreshWidget: Container(
                  width: double.infinity,
                  // height: double.infinity,
                  child: DataLoading()),
              onRefresh: !isInit
                  ? () async {
                      CommentModel comments = await _getEventComment();
                      if (mounted) {
                        _hotComments = addToModel(comments.hotComments);
                        _comments = addToModel(comments.comments);

                        hotTitle = "精彩评论";
                        title =
                            "最新评论 ${comments.total != 0 ? comments.total : ''}";
                        isInit = true;
                      }
                      setState(() {});
                      _controller.finishLoad(noMore: !comments.more);
                    }
                  : null,
              onLoad: () async {
                CommentModel comments =
                    await _getEventComment(offset: 20 * _pageIndex);
                if (comments.comments.length > 0) {
                  setState(() {
                    _comments.addAll(addToModel(comments.comments));
                    _pageIndex++;
                  });
                }
                _controller.finishLoad(noMore: !comments.more);
              },
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(40.0),
                          vertical: ScreenUtil().setWidth(20.0)),
                      child: Store.connect<PlaySongModel>(
                          builder: (context, songModel, child) {
                        return EventDescription(
                            event: widget.event,
                            isDetail: true,
                            model: songModel,
                            callback: (val) => _itemKey = val);
                      })),
                ),
                SliverToBoxAdapter(
                  child: _hotComments.length > 0
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(40.0),
                          ),
                          child: Text(
                            hotTitle,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(30.0),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(40.0),
                      top: ScreenUtil().setWidth(40.0),
                      bottom: ScreenUtil().setWidth(40.0)),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return CommentItem(
                        commentInfo: _hotComments[index],
                      );
                    }, childCount: _hotComments.length),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(40.0),
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(30.0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(40.0),
                      top: ScreenUtil().setWidth(40.0),
                      bottom: ScreenUtil().setWidth(40.0)),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return CommentItem(commentInfo: _comments[index]);
                    }, childCount: _comments.length),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
