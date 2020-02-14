import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/model/center_area_model.dart';

class UserCenterArea extends StatelessWidget {
  final CenterAreaModel area;
  UserCenterArea(this.area);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(250.0),
        margin: EdgeInsets.only(right: 10.0),
        width: (MediaQuery.of(context).size.width - 60) / 3,
        decoration: BoxDecoration(
            color: Color(0xfff1f1f1),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              area.subTitle,
              Column(children: <Widget>[
                area.icon,
                Text(area.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(25.0)))
              ]),
              area.subTitle
            ]));
  }
}
