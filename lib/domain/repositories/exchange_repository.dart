import 'package:exchange/core/repositories/repository.dart';
import 'package:exchange/core/result/result.dart';
import 'package:exchange/domain/entities/currency_entity.dart';

import '../../core/error/base_error.dart';

abstract class ExchangeRepository extends Repository {
  Future<Result<BaseError, List<CurrencyEntity>>> getCurrencies();

}
