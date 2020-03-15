import 'package:flutter/material.dart';

class DescDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.transparent,
        Colors.white10,
        Colors.white12,
        Colors.white10,
        Colors.transparent,
      ])),
    );
  }
}
