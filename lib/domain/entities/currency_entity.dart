import 'package:exchange/core/entities/base_entity.dart';
import 'package:flutter/cupertino.dart';


class CurrenciesDataEntity extends BaseEntity {
  final List<CurrencyEntity> currencies;
  final String lastUpdate;


  CurrenciesDataEntity({this.currencies, this.lastUpdate});

  @override
  List<Object> get props => [currencies, lastUpdate];

}

class CurrencyEntity extends BaseEntity {
  final String code;
  final String currency;
  final String sell;
  final String buy;
  final String flag;

  CurrencyEntity({
    @required this.code,
    @required this.currency,
    @required this.sell,
    @required this.buy,
    @required this.flag,
  });


  @override
  List<Object> get props => [flag, currency, code, sell, buy];
}
