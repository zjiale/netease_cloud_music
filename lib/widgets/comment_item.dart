import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neteast_cloud_music/model/comment_list_model.dart';

class CommentItem extends StatelessWidget {
  final CommentListModel commentInfo;
  CommentItem({@required this.commentInfo});
  @override
  Widget build(BuildContext context) {
    String _eventTime = DateUtil.yearIsEqual(
            DateTime.fromMillisecondsSinceEpoch(commentInfo.time),
            DateTime.now())
        ? DateUtil.isToday(commentInfo.time)
            ? "${DateUtil.formatDateMs(commentInfo.time, format: DataFormats.h_m)}"
            : DateUtil.isYesterday(
                    DateTime.fromMillisecondsSinceEpoch(commentInfo.time),
                    DateTime.now())
                ? "昨天${DateUtil.formatDateMs(commentInfo.time, format: DataFormats.h_m)}"
                : "${DateUtil.formatDateMs(commentInfo.time, format: 'M月dd日')}"
        : "${DateUtil.formatDateMs(commentInfo.time, format: 'yyyy/M/d')}";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ClipOval(
          child: ExtendedImage.network(commentInfo.avatarUrl,
              width: ScreenUtil().setWidth(60.0),
              height: ScreenUtil().setWidth(60.0)),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                right: ScreenUtil().setWidth(10.0),
                left: ScreenUtil().setWidth(20.0),
                bottom: ScreenUtil().setWidth(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(commentInfo.nickname,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: ScreenUtil().setSp(25.0))),
                    Padding(
                      padding:
                          EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '${commentInfo.likedCount == 0 ? '' : commentInfo.likedCount}',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: ScreenUtil().setSp(23.0)),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(5.0),
                          ),
                          Image.asset(
                            'assets/icon_event_liked.png',
                            width: ScreenUtil().setWidth(30.0),
                            height: ScreenUtil().setWidth(30.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5.0),
                ),
                Text(
                  _eventTime,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenUtil().setSp(18.0)),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10.0),
                ),
                Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
                  child: Text(
                    '${commentInfo.content}',
                    softWrap: true,
                  ),
                ),
                Divider()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
