import 'package:exchange/core/datasources/api_call_params.dart';

abstract class FunctionInstance<T> {
  final dynamic _function;
  final List<T> _arguments;

  FunctionInstance(this._function, this._arguments);

  dynamic invokeWithNewToken(String token);
}

class ApiCallFunction extends FunctionInstance<ApiCallParams> {
  ApiCallFunction(dynamic function, List<ApiCallParams> arguments)
      : super(function, arguments);

  invoke<T>() {
    return Function.apply(_function, [..._arguments]);
  }

  @override
  invokeWithNewToken(String token) {
    (_arguments as ApiCallParams).changeToken(token);
    List<dynamic> allArgs = [..._arguments, ...[]];

    return Function.apply(_function, allArgs);
  }
}
