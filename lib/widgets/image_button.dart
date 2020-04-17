import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/utils/config.dart';

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
        child: ExtendedImage.asset(
          "${Config().prefixImg(url)}",
          width: width,
          height: height,
          enableMemoryCache: true,
        ),
      ),
    );
  }
}
