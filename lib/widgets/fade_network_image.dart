import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class FadeNetWorkImage extends StatefulWidget {
  final String url;
<<<<<<< HEAD
  FadeNetWorkImage(this.url, {Key key});
=======
  final BoxFit fit;
  final double width;
  FadeNetWorkImage(this.url,
      {this.fit = BoxFit.contain, this.width = double.infinity, Key key});
>>>>>>> new
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
<<<<<<< HEAD
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
=======
        width: widget.width,
        height: widget.width,
        fit: widget.fit,
        color: Colors.black26,
        colorBlendMode: BlendMode.srcOver,
>>>>>>> new
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
<<<<<<< HEAD
            child: ExtendedRawImage(image: state.extendedImageInfo?.image),
=======
            child: ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              fit: widget.fit,
            ),
>>>>>>> new
          );
          break;
        case LoadState.failed:
          return null;
      }
    });
  }
}
