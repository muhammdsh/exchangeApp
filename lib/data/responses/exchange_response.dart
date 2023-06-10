import 'package:exchange/data/models/currency_model.dart';

import '../../core/response/api_response.dart';

class ExchangeResponse extends ApiResponse<List<CurrencyModel>> {
  ExchangeResponse(
    String msg,
    bool hasError,
    List<CurrencyModel> result,
  ) : super(msg, hasError, result);

  factory ExchangeResponse.fromJson(json) {
    String message = '';
    bool isSuccess = false;
    print('json ${json.runtimeType} $json');
    if (json is List) {
      isSuccess = json.isNotEmpty;
    }
    List<CurrencyModel> model;

    if (isSuccess) {
      model = (json as List).map((e) {
        return CurrencyModel.fromJson(e);
      }).toList();
    } else {
      message = "Something went wrong";
    }

    return ExchangeResponse(message, !isSuccess, model);
  }
}
