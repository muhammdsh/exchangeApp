
abstract class BaseValidator{

  bool validateFunction(String value);

  String getValidateMessage();

  static String validateValue(
      String value,
      List<BaseValidator> validators,
      bool isValidationActive,
      ) {
    if (!isValidationActive) return null;
    for (int i = 0; i < validators.length; i++) {
      if (!validators[i].validateFunction(value))
        return validators[i].getValidateMessage();
    }
    return null;
  }
  static isValidPhoneNumber(String phone) {
    // Only store the actual digits
    if (phone.startsWith("+963")) {
      final newPhone = phone.replaceAll(RegExp("[^0-9]"), "");
      print("newPhone$newPhone");
      return newPhone.isNotEmpty &&
          ((newPhone.startsWith('99639') && newPhone.length == 12));
    } else
      return true;
  }
}