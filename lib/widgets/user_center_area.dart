import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
<<<<<<< HEAD
import 'package:wangyiyun/model/center_area_model.dart';
=======
import 'package:neteast_cloud_music/model/center_area_model.dart';
>>>>>>> new

class UserCenterArea extends StatelessWidget {
  final CenterAreaModel area;
  final int index;
  UserCenterArea(this.area, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(250.0),
        margin: EdgeInsets.only(right: 10.0),
        width: (MediaQuery.of(context).size.width - 60) / 3,
        decoration: BoxDecoration(
            color: Color(0xfff1f1f1),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            image: index == 0 || index == 1
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/timg.jpg'),
                    colorFilter:
                        ColorFilter.mode(Colors.black54, BlendMode.srcOver))
                : null),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              area.header,
              Column(children: <Widget>[area.icon, area.title]),
              area.subTitle
            ]));
  }
}
