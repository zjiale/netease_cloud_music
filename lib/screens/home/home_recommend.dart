import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/screens/playlist/play_list_screen.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';
import 'package:wangyiyun/utils/numbers_convert.dart';

class HomeRecommend extends StatelessWidget {
  final List recommendList;

  HomeRecommend(this.recommendList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(260.0),
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0, left: 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlayListScreen()));
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