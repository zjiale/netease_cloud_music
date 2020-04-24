import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/widgets/flexible_detail_bar.dart';

class SliverAppBarCustom extends StatelessWidget {
  final double expandedHeight;
  final Widget title;
  final Widget content;
  final Widget background;
  final Widget bottom;
  final List<Widget> actions;
  SliverAppBarCustom(
      {this.expandedHeight,
      this.title,
      this.actions,
      this.content,
      this.background,
      this.bottom});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        pinned: true,
        expandedHeight: ScreenUtil().setHeight(expandedHeight),
        elevation: 0,
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0.0,
        title: title,
        actions: actions,
        flexibleSpace: FlexibleDetailBar(
            content: content,
            background: Container(
              color: Colors.white,
              child: background,
            )),
        bottom: bottom);
  }
}
