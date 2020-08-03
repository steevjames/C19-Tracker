import 'package:flutter/material.dart';

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    final double curverad = 40;

    Path path = Path();
    path.lineTo(0, rect.height + curverad);
    // Curve 1
    path.cubicTo(
        0, rect.height + curverad, 0, rect.height, curverad, rect.height);
    path.lineTo(rect.width - curverad, rect.height);
    // Curve 2
    path.cubicTo(rect.width - curverad, rect.height, rect.width, rect.height,
        rect.width, rect.height + curverad);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}
