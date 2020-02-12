import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';

class HomeRank extends StatelessWidget {
  final ScrollController controller;
  final ScrollPhysics physics;
  final List list;
  final double ratio;

  HomeRank(
    this.controller,
    this.physics,
    this.list,
    this.ratio,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: controller,
          itemCount: 5,
          physics: physics,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: MediaQuery.of(context).size.width - 60,
              margin: EdgeInsets.only(right: 10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Color(0xfff1f1f1),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('云音乐说唱排行榜',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(28.0),
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.keyboard_arrow_right,
                              size: ScreenUtil().setSp(45.0))
                        ]),
                    Container(
                      height: ScreenUtil().setHeight(300.0),
                      padding: EdgeInsets.only(top: 5.0),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Row(children: <Widget>[
                                PlayListCoverWidget(
                                  "https://uploads.5068.com/allimg/151109/48-151109110K6-50.jpg",
                                  width: 100,
                                ),
                                Expanded(child: Text('$index')),
                                Icon(Icons.play_arrow, size: 30.0)
                              ]),
                            );
                          }),
                    )
                  ]),
            );
          }),
    );
  }
}
