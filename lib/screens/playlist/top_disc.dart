import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
<<<<<<< HEAD
import 'package:wangyiyun/model/top_quality_play_list_model.dart';
import 'package:wangyiyun/widgets/play_list_cover.dart';
=======
import 'package:neteast_cloud_music/model/top_quality_play_list_model.dart';
import 'package:neteast_cloud_music/widgets/play_list_cover.dart';
>>>>>>> new

class TopDisc extends StatelessWidget {
  final List<Playlists> source;
  final callback;
  TopDisc({@required this.source, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(400.0),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20.0),
            vertical: ScreenUtil().setHeight(20.0)),
        child: new Swiper(
            loop: true,
            onTap: (index) {},
            onIndexChanged: (index) {
              callback(index);
            },
            control: new SwiperControl(
                color: Colors.transparent,
                padding: EdgeInsets.all(30.0),
                size: 50.0),
            layout: SwiperLayout.CUSTOM,
            customLayoutOption:
                new CustomLayoutOption(startIndex: 1, stateCount: 3)
                    .addTranslate([
              new Offset(
                  -ScreenUtil().setWidth(260.0) +
                      ScreenUtil().setWidth(260.0) / 4,
                  0.0),
              new Offset(
                  ScreenUtil().setWidth(260.0) -
                      ScreenUtil().setWidth(260.0) / 4,
                  0.0),
              new Offset(0.0, 0.0)
            ]).addScale([1.0, 1.0, 1.2], Alignment.center).addOpacity(
                        [0.7, 0.7, 1.0]),
            itemWidth: ScreenUtil().setWidth(260.0),
            itemHeight: ScreenUtil().setHeight(280.0),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    shape: BoxShape.rectangle),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(alignment: Alignment.bottomRight, children: <Widget>[
                      PlayListCoverWidget(
                        source[index].coverImgUrl,
                        circular: 5.0,
                        height: 230.0,
                        width: 260.0,
                        all: false,
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        width: ScreenUtil().setWidth(50.0),
                        height: ScreenUtil().setWidth(50.0),
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.play_arrow,
                            size: 20.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ]),
                    // SizedBox(height: 10.0),
                    Container(
                      height: ScreenUtil().setHeight(280.0) -
                          ScreenUtil().setHeight(230.0),
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Center(
                        child: Text(source[index].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style:
                                TextStyle(fontSize: ScreenUtil().setSp(16.0))),
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: source.length));
  }
}
