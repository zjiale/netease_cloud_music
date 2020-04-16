import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/netease_cloud_music_route.dart';
import 'package:netease_cloud_music/screens/playlist/play_list_detail_screen.dart';
import 'package:netease_cloud_music/widgets/play_list_cover.dart';
import 'package:netease_cloud_music/utils/numbers_convert.dart';

class HomeRecommend extends StatelessWidget {
  final List recommendList;
  final ScrollController controller;
  final ScrollPhysics physics;

  HomeRecommend(
      {@required this.recommendList,
      @required this.controller,
      @required this.physics});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(280.0),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40.0)),
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: physics,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                  context, Routes.NETEASECLOUDMUSIC_PLAYLISTDETAILSCREEN,
                  arguments: {
                    "expandedHeight": 520.0,
                    "id": recommendList[index].id,
                    "official": false,
                  });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Column(children: <Widget>[
                PlayListCoverWidget(recommendList[index].picUrl,
                    playCount: NumberUtils.amountConversion(
                        recommendList[index].playcount)),
                SizedBox(height: 5.0),
                Container(
                    width: ScreenUtil().setWidth(200.0),
                    child: Text(recommendList[index].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: ScreenUtil().setSp(23.0))))
              ]),
            ),
          );
        },
      ),
    );
  }
}
