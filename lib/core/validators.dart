import 'extensions/string.dart';

class Validator {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (value.trim().isNotEmail) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validateEmailOrPhoneNumber(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    if (value.isDigits) {
      if (value.isNotPhoneNumber) {
        return 'Invalid email or phone number';
      }
      if (value.length != 11) {
        return 'Phone number should be 11 in length';
      }
    } else if (value.isNotEmail) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    if (value.trim().length < 5) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? validateAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your account number';
    }
    if (value.trim().length != 11) {
      return 'Account number should be 11 in length';
    }
    return null;
  }

  static String? otpCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the correct code';
    }
    if (value.trim().length != 6) {
      return 'Incomplete code!';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter an amount';
    }
    // if (value.trim().length != 11) {
    //   return 'Phone number should be 11 in length';
    // }
    return null;
  }

  static String? password1(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a password';
    }
    String msg = 'Password must contain ;';

    if (value.trim().length < 6) msg += '\n - at least 7 characters';
    if (!value.trim().hasDigit) msg += '\n - at least one digit';
    if (!value.trim().hasLowercase) msg += '\n - at least one lowercase';
    if (!value.trim().hasUppercase) msg += '\n - at least one uppercase';
    if (!value.trim().hasSpecialCharacters) {
      msg += '\n - at least one special character';
    }
    if (msg.contains('\n')) return msg;

    return null;
  }

  static String? password2(String? value1, String value2) {
    if (value1 == null || value1.trim().isEmpty) {
      return 'Please enter a password';
    }
    if (value1.trim() != value2.trim()) {
      return 'Password mismatch';
    }
    return null;
  }

  static String? validatePin1(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a 4-digit pin';
    }
    return null;
  }

  static String? validatePins(List<String>? value) {
    if (value == null || value.first.length != 4) {
      return 'Please enter a 4-digit pin';
    }

    if (value.last.length != 4) {
      return 'Please re-enter a 4-digit pin';
    }

    if (value.first != value.last) {
      return 'Pin mismatch';
    }

    return null;
  }

  static String? validatePin2(String? value1, String value2) {
    if (value1 == null || value1.trim().isEmpty) {
      return 'Please enter a 4-digit pin';
    }
    if (value1.trim() != value2.trim()) {
      return 'Pin does not match';
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a amount';
    }
    // if (value.length != 10) {
    //   return 'Phone number should be 11 in length';
    // }
    return null;
  }

  static String? termsAndConditions(bool? value) {
    if (value == true) return null;
    return 'Please accept our terms and conditions.';
  }
}
