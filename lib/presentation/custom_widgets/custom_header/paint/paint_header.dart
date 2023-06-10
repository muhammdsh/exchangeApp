import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = locator<AppThemeColors>().primaryColor
      ..strokeWidth = 25.0;
    paint.style = PaintingStyle.fill;

    final path = Path();

    double height = ScreenUtil().statusBarHeight + 258.sp;

    path.lineTo(0, height);

    path.quadraticBezierTo(10.sp, height - 87.sp, 120.sp, height - 85.sp);
    path.lineTo(size.width - 60, height - 85.sp);
    path.quadraticBezierTo(size.width - 5.sp, height - 94.sp, size.width, height - 160.sp);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
