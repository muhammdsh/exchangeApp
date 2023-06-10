import 'package:exchange/core/models/base_model.dart';
import 'package:exchange/domain/entities/currency_entity.dart';
import 'package:flutter/cupertino.dart';

class CurrencyModel extends BaseModel<CurrencyEntity> {
  final String code;
  final String currency;
  final String sell;
  final String buy;
  final String flag;

  CurrencyModel({
    @required this.code,
    @required this.currency,
    @required this.sell,
    @required this.buy,
    @required this.flag,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      code: json['code'],
      currency: json['currency'],
      sell: json['sell'],
      buy: json['buy'],
      flag: json['flag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'currency': currency,
      'sell': sell,
      'buy': buy,
      'flag': flag,
    };
  }

  @override
  CurrencyEntity toEntity() =>
      CurrencyEntity(flag: flag,
          code: code,
          currency: currency,
          buy: buy,
          sell: sell);


}
