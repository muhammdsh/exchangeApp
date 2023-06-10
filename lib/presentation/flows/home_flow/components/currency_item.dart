import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CurrencyItem extends StatelessWidget {
  const CurrencyItem({Key key, this.flag, this.code, this.currency, this.buy, this.sell})
      : super(key: key);

  final String flag;
  final String code;
  final String currency;
  final String buy;
  final String sell;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Image.network(flag)),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 12.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        code,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        currency,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )),
            Expanded(
              child: Text(
                buy,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
                child: Text(
              sell,
              textAlign: TextAlign.end,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyMedium,
            )),
          ],
        ),
        const Divider()
      ],
    );
  }
}
