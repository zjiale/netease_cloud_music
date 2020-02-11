import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/widgets/my_special_textspan_builder.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';

class HomeRecommendSong extends StatefulWidget {
  final ScrollController controller;
  final ScrollPhysics physics;
  final List recommendSongList;
  final double ratio;

  HomeRecommendSong(
      this.controller, this.physics, this.recommendSongList, this.ratio);
  @override
  _HomeRecommendSongState createState() => _HomeRecommendSongState();
}

class _HomeRecommendSongState extends State<HomeRecommendSong> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300.0),
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          controller: widget.controller,
          itemCount: 9,
          physics: widget.physics,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 3,
              //纵轴间距
              mainAxisSpacing: 5.0,
              //横轴间距
              crossAxisSpacing: 10.0,
              //子组件宽高长度比例
              childAspectRatio: widget.ratio),
          itemBuilder: (BuildContext context, int index) {
            //Widget Function(BuildContext context, int index)
            return Column(children: <Widget>[
              Row(children: <Widget>[
                PlayListCoverWidget(
                  widget.recommendSongList[index].album.blurPicUrl,
                  width: 100,
                ),
                SizedBox(width: ScreenUtil().setWidth(10.0)),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      ExtendedText(
                          '${widget.recommendSongList[index].name} @- ${widget.recommendSongList[index].artists.first.name}e',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          specialTextSpanBuilder: MySpecialTextSpanBuilder(),
                          overFlowTextSpan:
                              OverFlowTextSpan(children: <TextSpan>[
                            TextSpan(text: '\u2026  '),
                            TextSpan(
                                text:
                                    "- ${widget.recommendSongList[index].artists.first.name}",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20.0),
                                    color: Colors.grey))
                          ])),
                      // Row(
                      //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Container(
                      //           // width: ScreenUtil().setWidth(300.0),
                      //           child: Text(
                      //         '${widget.recommendSongList[index].name}',
                      //         maxLines: 1,
                      //         overflow: TextOverflow.ellipsis,
                      //       )),
                      //       Text(
                      //           ' - ${widget.recommendSongList[index].artists.first.name}',
                      //           style: TextStyle(
                      //               fontSize: ScreenUtil().setSp(20.0),
                      //               color: Colors.grey))
                      //     ]),
                      SizedBox(height: ScreenUtil().setHeight(8.0)),
                      Text('${widget.recommendSongList[index].album.name}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(20.0),
                              color: Colors.grey))
                    ])),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.play_arrow,
                      size: 30.0, color: Theme.of(context).primaryColor),
                )
              ])
            ]);
          }),
    );
  }
}
