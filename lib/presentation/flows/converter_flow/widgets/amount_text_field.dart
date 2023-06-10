import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({Key key, this.onChange, this.controller, this.enable = true})
      : super(key: key);

  final Function(String) onChange;
  final TextEditingController controller;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.sp,
      margin: EdgeInsets.only(bottom: 13.sp),
      child: TextField(
        controller: controller,
        onChanged: onChange,
        enabled: enable,
        keyboardType: const TextInputType.numberWithOptions(),
        style: Theme.of(context).textTheme.titleLarge,
        cursorColor: locator<AppThemeColors>().secondaryColor,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            enabledBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: locator<AppThemeColors>().secondaryColor, width: 1.0),
            ),
            focusedBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: locator<AppThemeColors>().secondaryColor, width: 1.0),
            ),
            disabledBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: locator<AppThemeColors>().secondaryColor, width: 1.0),
            ),
            hintText: 0.toString(),
            hintStyle: Theme.of(context).textTheme.titleLarge),
        textAlign: TextAlign.center,
      ),
    );
  }
}
