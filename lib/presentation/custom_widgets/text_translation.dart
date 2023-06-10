
import 'package:exchange/core/helper/extensions/material_color_converter.dart';
import 'package:exchange/core/localization/app_lang.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show TextHeightBehavior;

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app+injection/di.dart';
import '../../core/resources/colors.dart';

class TextTranslation extends StatelessWidget {
  const TextTranslation(this.data,
      {Key key,
        this.style,
        this.strutStyle,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.softWrap,
        this.overflow,
        this.textScaleFactor,
        this.maxLines,
        this.semanticsLabel,
        this.textWidthBasis,
        this.textHeightBehavior,
        this.withTranslation = true})
      : super(key: key);
  final bool withTranslation;
  final String data;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;
  final ui.TextHeightBehavior textHeightBehavior;

  @override
  Widget build(BuildContext context) {
    return Text(
      withTranslation? data.tr(context) : data,
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    Key key,
    this.height = 40.0,
    this.width = 40.0,
    this.elevation = 1.0,
  }) : super(key: key);

  final double height;
  final double width;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.sp,
      width: width.sp,
      child: Card(
        elevation: elevation,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                locator<AppThemeColors>().secondaryColor.toMaterialColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

