import 'package:flutter/material.dart';

class HGap extends StatelessWidget {
  final double width;

  /// Adds space along the horizontal axis,
  /// translates to ```SizedBox(width: width)```
  const HGap(
    this.width, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

class VGap extends StatelessWidget {
  final double height;

  /// Adds space along the vertical axis,
  /// translates to ```SizedBox(height: height)```
  const VGap(
    this.height, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
