import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SongSubTitle extends StatelessWidget {
  final bool isHighQuality;
  final bool isVip;
  final String artists;
  final String album;
  final int status;

  SongSubTitle(
      {Key key,
      this.isHighQuality = true,
      this.isVip = true,
      @required this.artists,
      @required this.album,
      this.status = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Offstage(
          offstage: isHighQuality,
          child: Container(
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(5.0)),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 1.0, color: Colors.red)),
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: Text('SQ',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(15.0),
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          ),
        ),
        Offstage(
          offstage: isVip,
          child: Container(
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(5.0)),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 1.0, color: Colors.red)),
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: Text('VIP',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(15.0),
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          ),
        ),
        Flexible(
          child: Text('$artists - $album',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(20.0),
                  color: status == -200 ? Colors.grey : Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
