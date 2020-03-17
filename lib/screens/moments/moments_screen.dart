import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neteast_cloud_music/api/CommonService.dart';

class MomentsScreen extends StatefulWidget {
  @override
  _MomentsScreenState createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen> {
  List<Color> _data = [
    Colors.deepOrange,
    Colors.green,
    Colors.pinkAccent,
    Colors.blue,
    Colors.purple
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // type: 18 分享歌曲  24 分享专栏文章 13 分享歌单 39 发布视频
    // CommmonService().getEvent().then((res) {
    //   LogUtil.v(res);
    // });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    return Scaffold(
      backgroundColor: Colors.white,
      body: EasyRefresh.custom(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {},
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setWidth(130),
                  left: ScreenUtil().setWidth(40.0)),
              // height: ScreenUtil().setHeight(200.0),
              child: Row(
                children: _data.map((color) {
                  return Container(
                    width: ScreenUtil().setWidth(130.0),
                    padding:
                        EdgeInsets.only(right: ScreenUtil().setWidth(10.0)),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            ClipOval(
                              child: Container(
                                color: color,
                                width: ScreenUtil().setWidth(80.0),
                                height: ScreenUtil().setWidth(80.0),
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              child: Container(
                                width: ScreenUtil().setWidth(30.0),
                                height: ScreenUtil().setWidth(30.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: Center(
                                  child: Text(
                                    "V",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenUtil().setSp(18.0)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10.0),
                        ),
                        Text(
                          '云村有票官方号',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(22.0),
                              color: Colors.black54),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(color: Colors.black54, height: 1.0),
          )
        ],
      ),
    );
  }
}
