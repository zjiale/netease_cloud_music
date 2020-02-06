import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("推荐歌单",
                      style: TextStyle(
                          color: Color(0xffcdcdcd),
                          fontSize: ScreenUtil().setSp(23.0))),
                  SizedBox(height: 3.0),
                  Text("为你精挑细选",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(30.0),
                          fontWeight: FontWeight.bold))
                ]),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30.0),
                  border: new Border.all(
                    color: Color(0xffcdcdcd),
                    width: 1.0,
                  ),
                ),
                child: Row(children: <Widget>[
                  Icon(Icons.play_arrow,
                      color: Colors.black, size: ScreenUtil().setSp(30.0)),
                  SizedBox(width: 1.0),
                  Text('播放全部',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(25.0)))
                ]))
          ]),
    );
  }
}
