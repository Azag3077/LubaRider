extension StringExtension on String {
  String get title {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  bool get isEmail {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(pattern).hasMatch(this);
  }

  bool get isUrl {
    const String pattern =
        r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$";
    return RegExp(pattern).hasMatch(this);
  }

  bool get isNotEmail => !isEmail;

  bool get isPhoneNumber {
    const String pattern = r'^\+?[1-9]\d{1,14}$';
    return RegExp(pattern).hasMatch(this);
  }

  bool get isNotPhoneNumber => !isPhoneNumber;

  bool get isDigits => RegExp(r'^\d+$').hasMatch(this);

  bool get isNotDigits => !isDigits;

  bool get isNumber => RegExp(r'^[+-]?\d+(\.\d+)?$').hasMatch(this);

  bool get isNotNumber => !isNumber;

  String get camelCaseToWords {
    if (isEmpty) return this;
    final RegExp regex = RegExp(r'(?<=[a-z])(?=[A-Z])');
    return split(regex).map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  String get lowerCamelCaseToLowerSnakeCase =>
      split(RegExp(r'(?<=[a-z])(?=[A-Z])')).join('_').toLowerCase();

  bool get hasDigit => RegExp(r'\d').hasMatch(this);

  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(this);

  bool get hasLowercase => RegExp(r'[a-z]').hasMatch(this);

  bool get hasSpecialCharacters =>
      RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(this);

  String get formatToPrice {
    if (isEmpty) {
      return this;
    }

    final String str = double.parse(formatToString).toStringAsFixed(2);

    List<String> parts = str.split('.');
    String integerPart = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},');
    String result = integerPart;

    if (parts.length > 1) {
      result += '.${parts[1]}';
    }

    return result;
  }

  String get formatToString => replaceAll(',', '');

  bool get pathIsAsset => startsWith('assets/');

  // Remove all commas from text
  bool get isDigitWithAtLeast1Dot =>
      RegExp(r'^\d*\.?\d*$').hasMatch(replaceAll(',', ''));
}
