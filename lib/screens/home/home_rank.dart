import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/utils/my_special_textspan_builder.dart';
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
          itemCount: list.length,
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
                          Text(list[index]["title"],
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
                          itemCount: list[index]["content"].length,
                          itemBuilder: (BuildContext context, int ind) {
                            return Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Row(children: <Widget>[
                                  PlayListCoverWidget(
                                    "${list[index]["content"][ind].al.picUrl}",
                                    width: 100,
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(10.0)),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                        ExtendedText(
                                            '  @num${ind + 1}@  ${list[index]["content"][ind].name} @s- ${list[index]["content"][ind].ar.first.name}@',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            specialTextSpanBuilder:
                                                MySpecialTextSpanBuilder(),
                                            overFlowTextSpan: OverFlowTextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(text: '\u2026  '),
                                                  TextSpan(
                                                      text:
                                                          "- ${list[index]["content"][ind].ar.first.name}",
                                                      style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(20.0),
                                                          color: Colors.grey))
                                                ])),
                                        SizedBox(
                                            height:
                                                ScreenUtil().setHeight(8.0)),
                                      ]))
                                ]));
                          }),
                    )
                  ]),
            );
          }),
    );
  }
}
