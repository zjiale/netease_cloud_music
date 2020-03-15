import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neteast_cloud_music/widgets/play_list_cover.dart';

class UserCenterList extends StatelessWidget {
  final String url;
  final String title;
  final String subTitle;
  final bool create;
  final bool play;
  UserCenterList(this.title,
      {this.url =
          "https://uploads.5068.com/allimg/151109/48-151109110K6-50.jpg",
      this.subTitle,
      this.create = false,
      this.play = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 2,
      child: Row(children: <Widget>[
        Stack(alignment: Alignment.center, children: <Widget>[
          PlayListCoverWidget(url, width: 100.0, create: create),
          play
              ? Container(
                  width: ScreenUtil().setWidth(50.0),
                  height: ScreenUtil().setWidth(50.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white60),
                  child: Center(
                      child: Icon(Icons.play_arrow,
                          color: Colors.red,
                          size: ScreenUtil().setWidth(30.0))))
              : Container(),
          create
              ? Icon(Icons.add,
                  size: ScreenUtil().setSp(50.0), color: Colors.grey)
              : Container()
        ]),
        SizedBox(width: ScreenUtil().setWidth(10.0)),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: ScreenUtil().setWidth(200.0),
                  child: Text(title,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: ScreenUtil().setSp(23.0)))),
              SizedBox(height: ScreenUtil().setHeight(8.0)),
              subTitle != null
                  ? Text(subTitle,
                      style: TextStyle(
                          color: Color(0xffcdcdcd),
                          fontSize: ScreenUtil().setSp(20.0)))
                  : Container()
            ])
      ]),
    );
  }
}
