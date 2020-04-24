import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setWidth(40),
      padding: EdgeInsets.symmetric(horizontal: 60.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(ScreenUtil().setWidth(30))),
          border: Border.all(width: 0.0, color: Colors.white)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setWidth(40));
}
