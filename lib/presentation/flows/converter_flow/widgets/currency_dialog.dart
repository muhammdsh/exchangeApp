import 'package:exchange/domain/entities/currency_entity.dart';
import 'package:exchange/presentation/flows/home_flow/components/currency_item.dart';
import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  final List<CurrencyEntity> itemList;
  final Function(CurrencyEntity) onSelect;

  MyDialog({@required this.itemList, @required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Currency'),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                onSelect(itemList[index]);
                Navigator.of(context).pop();
              },
              child: CurrencyItem(
                flag: itemList[index].flag,
                code: itemList[index].code,
                currency: itemList[index].currency,
                buy: itemList[index].buy,
                sell: itemList[index].sell,
              ),
            );
          },
        ),
      ),
    );
  }
}