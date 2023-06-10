import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/localization/app_lang.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:exchange/core/resources/constants.dart';
import 'package:exchange/presentation/custom_widgets/custom_header/paint/paint_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key key, this.date}) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 277.sp - 100.sp + ScreenUtil().statusBarHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: HeaderPainter(),
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
            child: Image.asset(ImagesKeys.bigLogo),
          ),
          PositionedDirectional(
              top: 135.sp + 22.sp,
              start: 22.sp,
              child: Text(
                "${"Last Update at".tr(context)} $date",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    .copyWith(color: locator<AppThemeColors>().white),
              ))
        ],
      ),
    );
  }
}
/*
* SizedBox(
       // padding: EdgeInsets.symmetric(horizontal: 18.sp),

        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 20,
                child: Image.asset(ImagesKeys.bigLogo)),
            // ScreenUtil().setVerticalSpacing(22),
            // Text("dsfsfsdfd")
          ],
        ),
      ),
* */
