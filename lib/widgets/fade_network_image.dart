import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class FadeNetWorkImage extends StatefulWidget {
  final String url;
  final BoxFit fit;
  final double width;
  final bool pendantData;
  FadeNetWorkImage(this.url,
      {this.fit = BoxFit.contain,
      this.width = double.infinity,
      this.pendantData = false,
      Key key});
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
    return Stack(
      children: <Widget>[
        ExtendedImage.network(widget.url,
            width: widget.width,
            height: widget.width,
            fit: widget.fit, loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              _controller.reset();
              return Container();
              break;
            case LoadState.completed:
              _controller.forward();
              return FadeTransition(
                opacity: _controller,
                child: ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  fit: widget.fit,
                ),
              );
              break;
            case LoadState.failed:
              return null;
          }
        }),
        widget.pendantData
            ? Container()
            : Container(
                color: Colors.black12,
                width: widget.width,
                height: widget.width,
              )
      ],
    );
  }
}
