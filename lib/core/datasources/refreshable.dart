import 'package:dio/dio.dart';
import 'package:exchange/core/datasources/function_instance.dart';
import 'package:exchange/core/datasources/remote_data_source.dart';
import 'package:flutter/material.dart';

mixin RefreshableRemote {
  Map<String, FunctionInstance> redoInvoker = {};

  void addFunction(String name, FunctionInstance function) {
    redoInvoker[name] = function;
  }

  void invokeFunctionWithNewToken(String name, String token) {
    if (!redoInvoker.containsKey(name)) {
      throw Exception("this command '$name' not found");
    }

    FunctionInstance instance = redoInvoker[name];
    instance.invokeWithNewToken(token);
  }

  Future<String> refreshToken(
      {@required String refreshToken, @required String token}) async {
    Dio dio = Dio();

    dio.options.headers['refresh-token'] = refreshToken;
    dio.options.headers['Authorization'] = 'Bearer ${token}';
    try {
      Response response = await dio.post('/refresh-token');
      if(response.statusCode == 200){
        response.data['content'][''];
      }
     // return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
