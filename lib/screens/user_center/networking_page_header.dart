import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkingPageHeader implements SliverPersistentHeaderDelegate {
  NetworkingPageHeader({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final Duration duration = const Duration(milliseconds: 300);

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        Image.asset(
          'assets/timg.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          height: ScreenUtil().setWidth(40.0),
          width: double.infinity,
          color: Colors.white,
        )
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    double _opacity = 1.0 - max(0.0, shrinkOffset) / (maxExtent - minExtent);
    if (_opacity < 0) return 0.0;
    return _opacity;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
