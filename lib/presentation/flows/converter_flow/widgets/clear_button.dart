import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:exchange/presentation/custom_widgets/text_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({Key key, this.onClear}) : super(key: key);

  final VoidCallback onClear;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.sp),
      onTap: onClear,
      child: Container(
        height: 42.sp,
        width: 104.sp,
        decoration: BoxDecoration(
          border: Border.all(color: locator<AppThemeColors>().secondaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0.sp),
        ),
        child: Center(
          child: TextTranslation(
            'Clear',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
