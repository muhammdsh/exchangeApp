
import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  @override
  String getValidateMessage() {
    return "Required Input";
  }

  @override
  bool validateFunction(String value) {
    return value != null && value.isNotEmpty;
  }

}