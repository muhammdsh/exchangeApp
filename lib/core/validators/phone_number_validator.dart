
import 'base_validator.dart';

class PhoneNumValidator extends BaseValidator {

  final int minLength;


  PhoneNumValidator({this.minLength});

  @override
  String getValidateMessage() {
    return "Phone number is not valid";
  }

  @override
  bool validateFunction(String value) {
    return value.length >= this.minLength ? true : false;
  }

}