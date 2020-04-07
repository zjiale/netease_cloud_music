import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/rank.dart';
import 'package:netease_cloud_music/utils/my_special_textspan_builder.dart';
import 'package:netease_cloud_music/widgets/play_list_cover.dart';

class HomeRank extends StatelessWidget {
  final ScrollController controller;
  final ScrollPhysics physics;
  final List<Rank> list;
  final double ratio;

  HomeRank({
    @required this.controller,
    @required this.physics,
    @required this.list,
    @required this.ratio,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(350.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: controller,
          padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40.0)),
          itemCount: list.length,
          physics: physics,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: MediaQuery.of(context).size.width - 60,
              margin: EdgeInsets.only(right: 10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          list[index].bgColor.withOpacity(0.9),
                          BlendMode.srcOver),
                      image:
                          NetworkImage(list[index].content.first.al.picUrl))),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(list[index].title,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(32.0),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Icon(Icons.keyboard_arrow_right,
                              size: ScreenUtil().setSp(45.0),
                              color: Colors.white)
                        ]),
                    Flexible(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: list[index].content.length,
                          itemBuilder: (BuildContext context, int ind) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(10.0)),
                              child: Row(children: <Widget>[
                                PlayListCoverWidget(
                                  "${list[index].content[ind].al.picUrl}",
                                  width: 80,
                                ),
                                SizedBox(width: ScreenUtil().setWidth(10.0)),
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                      ExtendedText(
                                          '  @num${ind + 1}@  ${list[index].content[ind].name} @start- ${list[index].content[ind].ar.first.name}@',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(color: Colors.white),
                                          specialTextSpanBuilder:
                                              MySpecialTextSpanBuilder(),
                                          overFlowTextSpan: OverFlowTextSpan(
                                              children: <TextSpan>[
                                                TextSpan(text: '\u2026  '),
                                                TextSpan(
                                                    text:
                                                        "- ${list[index].content[ind].ar.first.name}",
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(20.0),
                                                        color: Colors.grey))
                                              ])),
                                    ]))
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
