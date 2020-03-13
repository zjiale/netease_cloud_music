import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class FadeNetWorkImage extends StatefulWidget {
  final String url;
  FadeNetWorkImage(this.url, {Key key});
  @override
  _FadeNetWorkImageState createState() => _FadeNetWorkImageState();
}

class _FadeNetWorkImageState extends State<FadeNetWorkImage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(widget.url,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        cache: true, loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          _controller.reset();
          return Container();
          break;
        case LoadState.completed:
          _controller.forward();
          return FadeTransition(
            opacity: _controller,
            child: ExtendedRawImage(image: state.extendedImageInfo?.image),
          );
          break;
        case LoadState.failed:
          return null;
      }
    });
  }
}
