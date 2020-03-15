import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescChip extends StatelessWidget {
  final String tag;
  DescChip({@required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(10.0)),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.black12,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Text(
        tag,
        style:
            TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(23.0)),
      ),
    );
  }
}
