import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayListBottom extends StatelessWidget implements PreferredSizeWidget {
  final int totalCount;
  final int subscribedCount;

  PlayListBottom(this.totalCount, this.subscribedCount);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(ScreenUtil().setWidth(30))),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20),
          ),
          child: InkWell(
              onTap: () {
                print('播放咯播放咯');
              },
              child: SizedBox.fromSize(
                  size: preferredSize,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Icon(Icons.play_circle_outline,
                              size: ScreenUtil().setWidth(50)),
                          SizedBox(width: ScreenUtil().setWidth(15.0)),
                          RichText(
                              text: TextSpan(
                                  text: '播放全部',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(30.0),
                                      color: Colors.black),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: '(共$totalCount首)',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(28.0),
                                        color: Color(0xffcdcdcd)))
                              ]))
                        ]),
                        InkWell(
                          onTap: () {
                            print('收藏啦啦啦啦啦');
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Row(children: <Widget>[
                                Text('+',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30.0),
                                        color: Colors.white)),
                                SizedBox(width: ScreenUtil().setWidth(10.0)),
                                Text('收藏 ($subscribedCount)',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(25.0),
                                        color: Colors.white))
                              ])),
                        )
                      ]))),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setWidth(100));
}
