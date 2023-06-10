//import 'package:vendor/features/user_management/domain/repositories/user_repository.dart';
import 'package:exchange/core/datasources/api_call_params.dart';
import 'package:exchange/core/datasources/refreshable.dart';
import 'package:exchange/core/error/http/unauthorized_error.dart';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api/api_helper.dart';
import '../enums/api/HttpMethod.dart';
import '../error/base_error.dart';
import '../error/custom_error.dart';
import '../factories/ModelFactory.dart';
import '../response/api_response.dart';
import '../services/session_manager.dart';

abstract class RemoteDataSource with RefreshableRemote {
  Future<Either<BaseError, Data>> request<Data, Response extends ApiResponse>(
    ApiCallParams<Response> params,
  ) async {
    ModelFactory.getInstance().registerModel(params.responseStr, params.mapper);

    final Map<String, String> headers = {};

    if (params.token != null && params.token.isNotEmpty) {
      headers.putIfAbsent(
          SessionManager.authorizeToken, () => 'Bearer ${params.token}');
      print('token: ${params.token}');
    }

    headers.putIfAbsent('content-Type', () => 'application/json');
    headers.putIfAbsent('x-rapidapi-host', () => 'meteostat.p.rapidapi.com');
    headers.putIfAbsent('x-rapidapi-key', () => '35411a4a83msh6f91ee62140f459p13f97ejsn910573656778');

    //  headers['content-Type'] = 'application/json';
    //  headers.putIfAbsent(LANGUAGE, () => acceptLang);

    print('data: ${params.data}');
    final response = await ApiHelper().sendRequest<Response>(
        method: params.method,
        url: params.url,
        data: params.data,
        headers: headers,
        cancelToken: params.cancelToken);

    print('123 123 Response: $response');

    if (response.isLeft()) {
      BaseError error = (response as Left<BaseError, Response>).value;
      if (error is UnauthorizedError) {
        final reToken = await refreshToken(
            refreshToken: params.refreshToken, token: params.token);
        ApiCallParams<Response> updatedParams = params.changeToken(reToken);
        request(updatedParams);
      }
      return Left(error);
    } else if (response.isRight()) {
      final resValue = (response as Right<BaseError, Response>).value;
      print('has error : ${resValue.hasError}');
      if (resValue.hasError) return Left(CustomError(message: resValue.msg));
      return Right(resValue.result);
    }
    return null;
  }
}


/*
*  if (response.statusCode == 200) {
        final token = response.data['content']['token'];
        final refreshToken = response.data['content']['refresh_token'];
        tokens.addAll([token, refreshToken]);
      }
      return tokens;
* */
