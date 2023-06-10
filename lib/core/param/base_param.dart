import 'package:dio/dio.dart';

abstract class BaseParams{
 final CancelToken cancelToken;
 const BaseParams({this.cancelToken});
}