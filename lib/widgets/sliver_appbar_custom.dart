import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
<<<<<<< HEAD
import 'package:wangyiyun/widgets/flexible_detail_bar.dart';
=======
import 'package:neteast_cloud_music/widgets/flexible_detail_bar.dart';
>>>>>>> new

class SliverAppBarCustom extends StatelessWidget {
  final double expandedHeight;
  final Widget title;
  final Widget content;
  final Widget background;
  final Widget bottom;
<<<<<<< HEAD
  SliverAppBarCustom(
      {this.expandedHeight,
      this.title,
=======
  final List<Widget> actions;
  SliverAppBarCustom(
      {this.expandedHeight,
      this.title,
      this.actions,
>>>>>>> new
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
<<<<<<< HEAD
=======
        actions: actions,
>>>>>>> new
        flexibleSpace:
            FlexibleDetailBar(content: content, background: background),
        bottom: bottom);
  }
}
