import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriberItem extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final bool showGender;
  final int gender;
  final bool showSignature;
  final String signature;

  SubscriberItem(
      {@required this.avatarUrl,
      @required this.name,
      this.showGender = false,
      this.gender,
      this.showSignature = false,
      this.signature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20.0),
          right: ScreenUtil().setWidth(20.0),
          bottom: ScreenUtil().setWidth(20.0)),
      child: Row(
        children: <Widget>[
          ClipOval(
              child: ExtendedImage.network(
            avatarUrl,
            fit: BoxFit.cover,
            width: ScreenUtil().setWidth(100.0),
            height: ScreenUtil().setWidth(100.0),
          )),
          Expanded(
            child: ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.only(left: ScreenUtil().setWidth(20.0)),
              title: Row(
                children: <Widget>[
                  Text(name,
                      style: TextStyle(fontSize: ScreenUtil().setSp(28.0))),
                  SizedBox(
                    width: ScreenUtil().setWidth(5.0),
                  ),
                  !showGender
                      ? Container()
                      : gender != 0
                          ? Image.asset(
                              "assets/${gender == 1 ? 'male' : 'female'}.png",
                              width: ScreenUtil().setWidth(20.0))
                          : Container()
                ],
              ),
              subtitle: !showGender
                  ? null
                  : signature != ''
                      ? Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(signature,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: ScreenUtil().setSp(20.0)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        )
                      : null,
            ),
          )
        ],
      ),
    );
  }
}
