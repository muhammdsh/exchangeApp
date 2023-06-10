import 'package:dartz/dartz.dart';
import 'package:exchange/core/datasources/remote_data_source.dart';
import 'package:exchange/core/error/base_error.dart';

import '../../models/currency_model.dart';


abstract class ExchangeDataSource extends RemoteDataSource {
  Future<Either<BaseError, List<CurrencyModel>>> getCurrencies();


}
