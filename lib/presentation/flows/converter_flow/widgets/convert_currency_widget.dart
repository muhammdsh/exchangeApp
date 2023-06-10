import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:exchange/core/resources/constants.dart';
import 'package:exchange/domain/entities/currency_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'amount_text_field.dart';

class ConvertCurrencyWidget extends StatelessWidget {
  const ConvertCurrencyWidget(
      {Key key,
      this.selectedCurrency,
      this.onSelect,
      this.onAmountChange,
      this.controller,
      this.enable = true})
      : super(key: key);

  final CurrencyEntity selectedCurrency;
  final VoidCallback onSelect;
  final Function(String) onAmountChange;
  final TextEditingController controller;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.sp,
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      decoration: BoxDecoration(
        color: locator<AppThemeColors>().surface,
        border: Border.all(color: Theme.of(context).primaryColorLight, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Image.network(selectedCurrency.flag)),
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 12.0.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: onSelect,
                      child: Row(
                        children: [
                          Text(
                            selectedCurrency.code,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          ScreenUtil().setHorizontalSpacing(12.sp),
                          SvgPicture.asset(
                            ImagesKeys.downArrow,
                            width: 22.sp,
                            color: locator<AppThemeColors>().secondaryColor,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      selectedCurrency.currency,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: AmountTextField(
                enable: enable,
                controller: controller,
                onChange: onAmountChange,
              )),
        ],
      ),
    );
  }
}
