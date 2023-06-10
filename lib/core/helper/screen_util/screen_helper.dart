import 'package:flutter/material.dart';


class ScreensHelper {
  static double width;
  static double height;

  ScreensHelper(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  static double fromWidth(double percent) {
    assert(percent != null && percent >= 0.0 && percent <= 100.0);
    return (percent/100.0) * width;
  }

  static fromHeight(double percent) {
    assert(percent != null && percent >= 0.0 && percent <= 100.0);
    return ((percent/100.0) * height);
  }

  // static scaleText(double fontSize, {bool allowFontScalingSelf}) {
  //   return ScreenUtil().setSp(fontSize, allowFontScalingSelf: allowFontScalingSelf);
  // }
}
