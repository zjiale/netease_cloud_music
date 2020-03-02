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
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 3.0,
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffcdcdcd).withOpacity(0.5))),
                    Positioned(
                        top: -7.0,
                        child: Container(
                            width: 4.0,
                            height: 13.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white)))
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffcdcdcd).withOpacity(0.5))),
                    Positioned(
                        top: -7.0,
                        child: Container(
                            width: 4.0,
                            height: 13.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white)))
                  ],
                )
              ]),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setWidth(40));
}
