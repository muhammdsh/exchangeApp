import 'package:dio/dio.dart';
import 'package:exchange/core/enums/api/HttpMethod.dart';
import 'package:flutter/foundation.dart';

class ApiCallParams<Response> {
  final String responseStr;
  final Response Function(dynamic) mapper;
  final HttpMethod method;
  final String url;
  final Map<String, String> queryParameters;
  final Map<String, dynamic> data;
  String token;
  final CancelToken cancelToken;
  final String acceptLang;
  final String refreshCaller;
  final String refreshToken;

  ApiCallParams({
    @required this.responseStr,
    @required this.mapper,
    @required this.method,
    @required this.url,
    this.queryParameters,
    this.refreshToken,
    this.refreshCaller,
    this.data,
    this.token,
    this.cancelToken,
    this.acceptLang = 'en',
  }) {
    assert(responseStr != null);
    assert(mapper != null);
    assert(method != null);
    assert(url != null);
  }

  ApiCallParams changeToken(String token) {
    this.token = token;
    return this;
  }
}
