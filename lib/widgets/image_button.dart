import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangyiyun/utils/config.dart';

class ImageButton extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final Function() fun;

  ImageButton(this.width, this.height, this.url, {this.fun});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: fun,
        child: Image.asset("${Config().prefixImg(url)}",
            width: width, height: height),
      ),
    );
  }
}
