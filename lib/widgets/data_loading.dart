import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DataLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SpinKitWave(color: Theme.of(context).primaryColor, size: 20.0),
      SizedBox(
        width: 5.0,
      ),
      Text(
        '正在努力加载中..',
        style: TextStyle(
            fontSize: ScreenUtil().setSp(25.0), color: Colors.black54),
      )
    ]);
  }
}
