import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/widgets/play_list_cover.dart';

class SongItem extends StatelessWidget {
  final bool showIndex;
  final bool isSearch;
  final bool hasMv;
  final String picUrl;
  final Widget title;
  final Widget subTitle;
  final int type;
  final double height;
  final int playCount;
  final int index;

  SongItem(
      {this.showIndex = false,
      this.picUrl = '',
      this.hasMv = true,
      this.isSearch = false,
      @required this.title,
      @required this.subTitle,
      this.type = 0, // 0: 歌曲 1: 专辑 2: 歌单 4: 视频
      this.height = 0,
      this.playCount = 0,
      this.index = 0});

  @override
  Widget build(BuildContext context) {
    Widget _buildPic() {
      double width;
      switch (type) {
        case 0:
          width = 80.0;
          break;
        case 4:
          width = 230.0;
          break;
        default:
          width = 100.0;
      }

      return picUrl != ''
          ? PlayListCoverWidget(
              picUrl,
              circular: type == 0 ? 8.0 : 5.0,
              width: width,
              height: height != 0 ? height : 0,
              isAlbum: type == 1 ? true : false,
              playCount: type == 4 ? '$playCount' : '',
              fit: BoxFit.cover,
            )
          : Container();
    }

    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Offstage(
            offstage: showIndex,
            child: Container(
              width: ScreenUtil().setWidth(60.0),
              child: Center(
                child: Text('${1 + index}',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(30.0),
                        color: Colors.black45)),
              ),
            ),
          ),
          _buildPic(),
          Expanded(
              child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(left: 12.0),
                  title: title,
                  subtitle: subTitle,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Offstage(
                        offstage: hasMv ? true : false,
                        child: Container(
                          width: ScreenUtil().setWidth(35.0),
                          height: ScreenUtil().setWidth(30.0),
                          margin: EdgeInsets.only(right: 5.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border:
                                  Border.all(width: 1.0, color: Colors.grey),
                              borderRadius: BorderRadius.circular(6.0)),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              size: ScreenUtil().setWidth(20.0),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      isSearch
                          ? Container()
                          : IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            )
                    ],
                  )))
        ]);
  }
}
