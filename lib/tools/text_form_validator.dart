import 'package:afsha/tools/Constants.dart';
import 'package:afsha/tools/validator.dart';

class TextFieldValidators {
  static String isEmail(String email) {
    if (Validator.isEmail(email)) return null;
    return Constants.EMAIL_REQUIRED;
  }

  static String isName(String name) {
    if (Validator.isName(name)) return null;
    return Constants.NAME_REQUIRED;
  }

  static String isPhone(String phone) {
    if (Validator.isPhone(phone)) return null;
    return Constants.PHONE_REQUIRED;
  }

  static String isPassword(String password) {
    if (Validator.isPassword(password)) return null;
    return Constants.PASSWORD_REQUIRED;
  }

  static String confirmPasswordValidator(
      String password, String confirmPassword) {
    if (confirmPassword != password) {
      return Constants.IDENTICAL_PASSWORD_REQUIRED;
    }
    return null;
  }
}
