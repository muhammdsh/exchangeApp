import 'package:exchange/core/resources/constants.dart';
import 'package:exchange/domain/entities/currency_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'currency_header.dart';
import 'currency_item.dart';



class CurrencyList extends StatelessWidget {
  const CurrencyList({Key key, this.data, this.scrollController}) : super(key: key);
  final ScrollController scrollController;
  final List<CurrencyEntity> data;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.sp),
          child: const CurrencyHeader(),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.sp),
          child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.zero,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return CurrencyItem(
                flag: data[index].flag,
                code: data[index].code,
                currency: data[index].currency,
                buy: data[index].buy,
                sell: data[index].sell,
              );
            },
          ),
        )),
      ],
    );
  }
}
