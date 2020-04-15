import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SongTitle extends StatelessWidget {
  final String name;
  final bool isMv;
  final int type;
  final int status;
  final String transName;

  SongTitle(
      {Key key,
      @required this.name,
      this.isMv = false,
      this.type = 1,
      this.status = 0,
      this.transName = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        isMv && type == 0
            ? Container(
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(5.0)),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 1.0, color: Colors.red)),
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Text('MV',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(15.0),
                        fontWeight: FontWeight.bold,
                        color: Colors.red[400])),
              )
            : SizedBox(),
        Flexible(
          child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: isMv ? 2 : 1,
              text: TextSpan(
                  text: name,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(26.0),
                      color: status == -200 ? Colors.grey : Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: transName != '' ? '（$transName）' : '',
                        style: TextStyle(color: Colors.grey))
                  ])),
        ),
      ],
    );
  }
}
