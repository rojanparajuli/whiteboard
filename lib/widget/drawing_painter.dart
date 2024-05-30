import 'dart:ui';

import 'package:flutter/material.dart';
import 'drawing_area.dart';

class DrawingPainter extends CustomPainter {
  DrawingPainter({required this.pointsList});

  List<DrawingArea?> pointsList;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      print('ll ${pointsList.length}');
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i]!.point, pointsList[i + 1]!.point, pointsList[i]!.areaPaint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [pointsList[i]!.point], pointsList[i]!.areaPaint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) {
    return oldDelegate.pointsList != pointsList;
  }
}
