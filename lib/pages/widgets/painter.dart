import 'package:flutter/material.dart';

import '../constant.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3178571, size.height * 0.08150996);
    path_0.cubicTo(
        size.width * 0.1730989,
        size.height * 0.05421877,
        size.width * 0.01714239,
        size.height * 0.1206372,
        0,
        size.height * 0.1209057);
    path_0.lineTo(0, size.height * 0.5332261);
    path_0.lineTo(size.width, size.height * 0.5332261);
    path_0.lineTo(size.width, 0);
    path_0.cubicTo(
        size.width * 0.9684357,
        size.height * 0.04753563,
        size.width * 0.8785714,
        size.height * 0.1285640,
        size.width * 0.8214286,
        size.height * 0.1586782);
    path_0.cubicTo(
        size.width * 0.6861464,
        size.height * 0.1763755,
        size.width * 0.5585464,
        size.height * 0.1268866,
        size.width * 0.3178571,
        size.height * 0.08150996);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = appBarColor;
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(0, size.height * 0.5068774);
    path_1.lineTo(size.width, size.height * 0.5068774);
    path_1.lineTo(size.width, size.height * 0.9616858);
    path_1.cubicTo(size.width, size.height * 0.9828467, size.width * 0.9840107,
        size.height, size.width * 0.9642857, size.height);
    path_1.lineTo(size.width * 0.03571429, size.height);
    path_1.cubicTo(size.width * 0.01598982, size.height, 0,
        size.height * 0.9828467, 0, size.height * 0.9616858);
    path_1.lineTo(0, size.height * 0.5068774);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = appBarColor;
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}