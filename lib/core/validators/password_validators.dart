import 'package:flutter/foundation.dart';

import 'base_validator.dart';


class PasswordValidator extends BaseValidator {
  final int minLength;

  PasswordValidator({@required this.minLength});

  @override
  String getValidateMessage() {
    return 'password minimum length is $minLength';
  }

  @override
  bool validateFunction(String value) {
    return value.length > minLength ? true : false;
  }
}
