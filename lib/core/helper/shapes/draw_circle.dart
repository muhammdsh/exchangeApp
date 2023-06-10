import 'package:flutter/cupertino.dart';

class DrawCircle extends CustomPainter {
  Paint _paint;
  double radius;

  DrawCircle({Color color, double strokeWidth, double radius, PaintingStyle style = PaintingStyle.fill}) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = style;
    this.radius = radius;
    assert(radius != null);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), radius, _paint);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}