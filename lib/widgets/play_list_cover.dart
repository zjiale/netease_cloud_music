import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayListCoverWidget extends StatelessWidget {
  final String url;
  final String playCount;
  final double width;
  final bool isAlbum;
  final bool create;

  PlayListCoverWidget(this.url,
      {this.playCount,
      this.width = 200,
      this.isAlbum = false,
      this.create = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          child: Container(
            width: ScreenUtil().setWidth(width),
            height: ScreenUtil().setWidth(width),
            color: Color(0xfff1f1f1),
            child: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                create == false
                    ? ExtendedImage.network(url, fit: BoxFit.cover, cache: true)
                    : Container(),
                playCount == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(2),
                            right: ScreenUtil().setWidth(5)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              'assets/icon_triangle.png',
                              width: ScreenUtil().setWidth(30),
                              height: ScreenUtil().setWidth(30),
                            ),
                            Text(
                              playCount,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
        isAlbum
            ? Image.asset('assets/icon_album.png',
                height: ScreenUtil().setWidth(width))
            : Container(),
      ],
    );
  }
}
