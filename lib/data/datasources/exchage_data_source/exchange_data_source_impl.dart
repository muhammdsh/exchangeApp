import 'package:dartz/dartz.dart';
import 'package:exchange/core/datasources/api_call_params.dart';
import 'package:exchange/core/datasources/function_instance.dart';
import 'package:exchange/core/enums/api/HttpMethod.dart';
import 'package:exchange/core/resources/apis.dart';
import 'package:exchange/data/datasources/exchage_data_source/exchange_data_source.dart';

import '../../../core/error/base_error.dart';
import '../../models/currency_model.dart';
import '../../responses/exchange_response.dart';

class ExchangeDataSourceImpl extends ExchangeDataSource {

  @override
  Future<Either<BaseError, List<CurrencyModel>>> getCurrencies() {
    ApiCallFunction instance = ApiCallFunction(
        () => request<List<CurrencyModel>, ExchangeResponse>(
            ApiCallParams<ExchangeResponse>(
                responseStr: "ExchangeResponse",
                mapper: (json) => ExchangeResponse.fromJson(json),
                method: HttpMethod.GET,
                refreshCaller: 'exchangeDataSourceImpl-getCurrencies',
                url: ApiUrls.getCurrencies)),
        []);

    addFunction('exchangeDataSourceImpl-getCurrencies', instance);

    return instance.invoke<List<CurrencyModel>>();
  }


}
