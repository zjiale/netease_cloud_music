import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/comment_list_model.dart';
import 'package:netease_cloud_music/model/comment_model.dart';

import 'package:netease_cloud_music/store/model/play_song_model.dart';
import 'package:netease_cloud_music/widgets/comment_item.dart';
import 'package:netease_cloud_music/widgets/data_loading.dart';
import 'package:netease_cloud_music/widgets/play_list_cover.dart';

class SongComment extends StatefulWidget {
  final PlaySongModel songModel;

  SongComment({@required this.songModel});

  @override
  _SongCommentState createState() => _SongCommentState();
}

class _SongCommentState extends State<SongComment> {
  EasyRefreshController _controller = EasyRefreshController();

  bool isInit = false;
  List<CommentListModel> _hotCommentList = [];
  List<CommentListModel> _commentList = [];
  int pageSize = 0;
  String hotTitle = "";
  String title = "";

  Future getComment(List comments) async {
    List<CommentListModel> _list = [];
    comments.forEach((comment) {
      if (comment.parentCommentId != 0) return;
      _list.add((CommentListModel(
          id: comment.commentId,
          nickname: comment.user.nickname,
          avatarUrl: comment.user.avatarUrl,
          content: comment.content,
          time: comment.time,
          liked: comment.liked,
          likedCount: comment.likedCount)));
    });
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '评论(${widget.songModel.comment.total})',
          style: TextStyle(color: Colors.black),
        ),
        titleSpacing: 0.0,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: EasyRefresh.custom(
          controller: _controller,
          footer: MaterialFooter(),
          firstRefresh: true,
          firstRefreshWidget: Container(
              width: double.infinity,
              // height: double.infinity,
              child: DataLoading()),
          onRefresh: !isInit
              ? () async {
                  List<CommentListModel> hotComment =
                      await getComment(widget.songModel.comment.hotComments);
                  List<CommentListModel> comments =
                      await getComment(widget.songModel.comment.comments);
                  hotTitle = "精彩评论";
                  title = "最新评论";
                  if (mounted) {
                    _hotCommentList.addAll(hotComment);
                    _commentList.addAll(comments);
                    isInit = true;
                    pageSize++;
                    setState(() {});
                  }
                  _controller.finishLoad(
                      noMore: !widget.songModel.comment.more);
                }
              : null,
          onLoad: () async {
            widget.songModel.getSongComment(offset: pageSize * 20);
            CommentModel commentModel = widget.songModel.comment;
            List<CommentListModel> comments =
                await getComment(commentModel.comments);

            if (mounted) {
              _commentList.addAll(comments);
              pageSize++;
            }
            setState(() {});
            _controller.finishLoad(noMore: !commentModel.more);
          },
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      height: ScreenUtil().setHeight(150.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(40.0)),
                      child: Row(
                        children: <Widget>[
                          PlayListCoverWidget(
                            widget.songModel.curSong.picUrl,
                            circular: 5.0,
                            fit: BoxFit.cover,
                            width: 140.0,
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(10.0),
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.songModel.curSong.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(32.0))),
                                SizedBox(
                                  height: ScreenUtil().setHeight(10.0),
                                ),
                                Text(
                                  widget.songModel.curSong.artists,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(30.0),
                                      color: Colors.blueAccent[200]),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Color(0xfff1f1f1).withOpacity(0.6),
                      height: 10.0,
                      thickness: 10.0,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _hotCommentList.length > 0
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(40.0),
                          vertical: ScreenUtil().setWidth(20.0)),
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
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return CommentItem(
                      commentInfo: _hotCommentList[index],
                    );
                  }, childCount: _hotCommentList.length),
                )),
            SliverToBoxAdapter(
              child: widget.songModel.comment.moreHot
                  ? Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '查看更多精彩评论',
                              style: TextStyle(color: Colors.blue)),
                          WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.blue,
                              ))
                        ]),
                      ),
                    )
                  : Container(),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(40.0),
                    vertical: ScreenUtil().setWidth(20.0)),
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
                    return CommentItem(
                      commentInfo: _commentList[index],
                    );
                  }, childCount: _commentList.length),
                ))
          ]),
    );
  }
}
