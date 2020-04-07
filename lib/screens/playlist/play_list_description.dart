import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/play_list.detail.dart';
import 'package:netease_cloud_music/widgets/desc_chip.dart';
import 'package:netease_cloud_music/widgets/desc_divider.dart';
import 'package:netease_cloud_music/widgets/fade_network_image.dart';

class PlayListDescription extends StatelessWidget {
  final Color bgColor;
  final PlayListDetailModel detail;
  PlayListDescription({@required this.bgColor, @required this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Stack(children: <Widget>[
          Container(
            color: bgColor,
            width: double.infinity,
            height: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 30,
              sigmaX: 30,
            ),
            child: Container(
              color: Colors.black26,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            bottom: false,
            child: Stack(
              // alignment: Alignment.center,
              children: <Widget>[
                SingleChildScrollView(
                    padding: EdgeInsets.only(top: kToolbarHeight),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(80.0),
                          vertical: ScreenUtil().setHeight(40.0)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: FadeNetWorkImage(
                                  detail.playlist.coverImgUrl,
                                  width: ScreenUtil().setWidth(400.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(30.0),
                            ),
                            Text(
                              detail.playlist.name,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(28.0),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(40.0),
                            ),
                            DescDivider(),
                            SizedBox(
                              height: ScreenUtil().setHeight(15.0),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '标签:',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(25.0)),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(20.0),
                                ),
                                ...detail.playlist.tags
                                    .map((tag) => DescChip(tag: tag))
                                    .toList()
                              ],
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(20.0),
                            ),
                            Text(detail.playlist.description,
                                softWrap: true,
                                strutStyle: StrutStyle(
                                    forceStrutHeight: true, height: 1.5),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(23.0)))
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    top: 0.0,
                    child: Container(
                        // color: Colors.white.withOpacity(0.3),
                        alignment: Alignment.centerRight,
                        padding:
                            EdgeInsets.only(right: ScreenUtil().setWidth(40.0)),
                        width: MediaQuery.of(context).size.width,
                        height: kToolbarHeight,
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                        )))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
