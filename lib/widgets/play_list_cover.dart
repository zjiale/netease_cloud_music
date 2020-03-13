import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/widgets/fade_network_image.dart';

class PlayListCoverWidget extends StatefulWidget {
  final String url;
  final String playCount;
  final double width;
  final double height;
  final double circular;
  final bool isAlbum;
  final bool create;
  final bool all;

  PlayListCoverWidget(this.url,
      {this.playCount,
      this.width = 200,
      this.height = 0,
      this.circular = 8.0,
      this.isAlbum = false,
      this.create = false,
      this.all = true});

  @override
  _PlayListCoverWidgetState createState() => _PlayListCoverWidgetState();
}

class _PlayListCoverWidgetState extends State<PlayListCoverWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: widget.all
              ? BorderRadius.all(Radius.circular(widget.circular))
              : BorderRadius.only(
                  topLeft: Radius.circular(widget.circular),
                  topRight: Radius.circular(widget.circular)),
          child: Container(
            width: ScreenUtil().setWidth(widget.width),
            height: widget.height != 0
                ? ScreenUtil().setHeight(widget.height)
                : ScreenUtil().setWidth(widget.width),
            color: Color(0xfff1f1f1),
            child: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                widget.create == false
                    ? FadeNetWorkImage(widget.url)
                    : Container(),
                widget.playCount == null
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
                              widget.playCount,
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
        widget.isAlbum
            ? Image.asset('assets/icon_album.png',
                height: ScreenUtil().setWidth(widget.width))
            : Container(),
      ],
    );
  }
}
