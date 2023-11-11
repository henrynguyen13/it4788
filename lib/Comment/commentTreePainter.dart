// ignore: file_names
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class CommentTreePainter extends CustomPainter {
  double? startX;
  double? startY;
  double? endX;
  double? endY;
  double curvedRadius;
  GlobalKey parentKey;
  GlobalKey childKey;

  CommentTreePainter({
    required this.curvedRadius,
    required this.parentKey,
    required this.childKey,
  });

  void getPositionValue() {
    RenderBox renderbox1 =
        parentKey.currentContext!.findRenderObject() as RenderBox;
    Offset position1 = renderbox1.localToGlobal(Offset.zero);
    double x1 = position1.dx;
    double y1 = position1.dy;
    double width1 = renderbox1.size.width;
    double height1 = renderbox1.size.height;
    startX = x1 + width1 / 2;
    startY = y1 + height1 + 5;

    RenderBox renderbox2 =
        childKey.currentContext!.findRenderObject() as RenderBox;
    Offset position2 = renderbox2.localToGlobal(Offset.zero);
    double x2 = position2.dx;
    double y2 = position2.dy;
    double height2 = renderbox2.size.height;
    endX = x2 - 5;
    endY = y2 + height2 / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    getPositionValue();

    Offset offset = const Offset(-70, -290);
    final rect = Rect.fromLTRB(
        startX! + offset.dx,
        endY! - 2 * curvedRadius + offset.dy,
        startX! + 2 * curvedRadius + offset.dx,
        endY! + offset.dy);
    const startAngle = math.pi;
    const sweepAngle = -math.pi / 2;
    const useCenter = false;
    final paint = Paint()
      ..color = const Color.fromARGB(255, 185, 185, 185)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(Offset(startX!, startY!) + offset,
        Offset(startX!, endY! - curvedRadius) + offset, paint);
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
    canvas.drawLine(Offset(startX! + curvedRadius, endY!) + offset,
        Offset(endX!, endY!) + offset, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
