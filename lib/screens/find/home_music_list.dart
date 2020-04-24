import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/music_song_model.dart';
import 'package:netease_cloud_music/store/index.dart';
import 'package:netease_cloud_music/store/model/play_song_model.dart';
import 'package:netease_cloud_music/utils/my_special_textspan_builder.dart';
import 'package:netease_cloud_music/widgets/play_list_cover.dart';

class HomeMusicList extends StatelessWidget {
  final ScrollController controller;
  final ScrollPhysics physics;
  final List list;
  final double ratio;
  final bool isAlbum;

  HomeMusicList(
      {@required this.controller,
      @required this.physics,
      @required this.list,
      @required this.ratio,
      this.isAlbum = false});

  _play(int index, PlaySongModel model) {
    MusicSong song;
    if (isAlbum != true) {
      song = MusicSong(
          id: list[index].id,
          duration: list[index].duration,
          name: list[index].name,
          artists: list[index].artists.first.name,
          picUrl: list[index].album.blurPicUrl);
      model.playOneSong(song);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320.0),
      child: GridView.builder(
          padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40.0)),
          scrollDirection: Axis.horizontal,
          controller: controller,
          itemCount: list.length,
          physics: physics,
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 3,
              //横轴间距
              crossAxisSpacing: ScreenUtil().setWidth(25.0),
              //子组件宽高长度比例
              childAspectRatio: ratio),
          itemBuilder: (BuildContext context, int index) {
            //Widget Function(BuildContext context, int index)
            return Store.connect<PlaySongModel>(
                builder: (context, model, child) {
              return GestureDetector(
                  onTap: () => _play(index, model),
                  child: Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(10.0)),
                    child: Row(children: <Widget>[
                      PlayListCoverWidget(
                        isAlbum != true
                            ? list[index].album.blurPicUrl
                            : list[index].blurPicUrl,
                        width: 100,
                        isAlbum: isAlbum,
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10.0)),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            ExtendedText(
                                '${list[index].name} @start- ${list[index].artists.first.name}@',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                specialTextSpanBuilder:
                                    MySpecialTextSpanBuilder(),
                                overFlowTextSpan:
                                    OverFlowTextSpan(children: <TextSpan>[
                                  TextSpan(text: '\u2026  '),
                                  TextSpan(
                                      text:
                                          "- ${list[index].artists.first.name}",
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(20.0),
                                          color: Colors.grey))
                                ])),
                            SizedBox(height: ScreenUtil().setHeight(8.0)),
                            !isAlbum
                                ? Text('${list[index].album.name}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(20.0),
                                        color: Colors.grey))
                                : Container()
                          ])),
                      SizedBox(width: ScreenUtil().setWidth(13.0)),
                      !isAlbum
                          ? Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: model.curList.length > 0 &&
                                      model.curSong.id == list[index].id
                                  ? Icon(Icons.volume_up,
                                      size: ScreenUtil().setWidth(40.0),
                                      color: Theme.of(context).primaryColor)
                                  : Container(
                                      width: ScreenUtil().setWidth(45.0),
                                      height: ScreenUtil().setWidth(45.0),
                                      // padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Color(0xffcdcdcd),
                                              width: 1.0)),
                                      child: Center(
                                          child: Icon(Icons.play_arrow,
                                              size: ScreenUtil().setSp(30.0),
                                              color: Theme.of(context)
                                                  .primaryColor))))
                          : Container(
                              width: 30.0,
                              padding: EdgeInsets.only(right: 10.0))
                    ]),
                  ));
            });
          }),
    );
  }
}
