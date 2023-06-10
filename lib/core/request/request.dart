import 'package:dio/dio.dart';
import 'dart:convert';

abstract class BaseRequest {}

abstract class PostRequest extends BaseRequest {
  FormData toJson();
}

abstract class Request extends BaseRequest {
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Request &&
          runtimeType == other.runtimeType &&
          jsonEncode(toJson()) == jsonEncode(other.toJson());

  @override
  int get hashCode => jsonEncode(toJson()).hashCode;
}
