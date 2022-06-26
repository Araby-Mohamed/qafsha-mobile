import 'Constants.dart';


class Validator {
  static bool isEGPhoneNumber(String phone) {
    if (phone == null || phone.isEmpty) {
      return false;
    }

    final RegExp exp = RegExp(Constants.EG_PHONE_REGEX);
    return exp.hasMatch(phone);
  }

  static bool isEmail(String email) {
    if (email == null || email.isEmpty) {
      return false;
    }

    final RegExp exp = RegExp(Constants.EMAIL_REGEX);
    return exp.hasMatch(email);
  }

  static bool isValid(String value) {
    return value.isNotEmpty;
  }

  static bool isSmsCode(String code) {
    return code.length == 5;
  }

  static bool isPassword(String password) {
    return password.isNotEmpty;
  }

  static bool isPasswordsIdentical(
      String password, String confirmationPassword) {
    return password == confirmationPassword;
  }

  static bool isName(String name) {
    return name.length >= 3;
  }

  static bool isAddress(String address) {
    return address.isNotEmpty;
  }

  static bool isPhone(String phone) {
    return phone.isNotEmpty;
  }

  static bool isNationality(String nationality) {
    return nationality.isNotEmpty;
  }

  static bool isIdNumber(String idNumber) {
    return idNumber.isNotEmpty;
  }

  static bool isDestination(String destination) {
    return destination.isNotEmpty;
  }

  static bool isIdExpireDate(String expireDate) {
    return expireDate.isNotEmpty;
  }

  static bool isCountry(String address) {
    return address.isNotEmpty;
  }

  static bool isMasterCardNumber(String masterCard) {
    // TODO(andelrahman): validate with regex
    return masterCard.isNotEmpty && masterCard.length == 16;
  }

  static bool isYearNumber(String digitNumber) {
    return digitNumber.isNotEmpty && digitNumber.length == 4;
  }

  static bool isAmount(String amount) {
    return amount.isNotEmpty;
  }

  static bool isTwoDigitNumber(String digitNumber) {
    return digitNumber.isNotEmpty && digitNumber.length == 2;
  }

  static bool isThreeDigitNumber(String digitNumber) {
    return digitNumber.isNotEmpty && digitNumber.length == 3;
  }

  static bool isCardHeaderNameNumber(String name) {
    return name.isNotEmpty && name.length > 2;
  }

  static bool isCodeCorrect(String codeFromUser, String correctCode) {
    if (!Validator.isSmsCode(codeFromUser)) {
      return false;
    }

    final String codeFromUserReversed = codeFromUser.split('').reversed.join();

    if (codeFromUser == correctCode || codeFromUserReversed == correctCode) {
      return true;
    }

    return false;
  }
}
