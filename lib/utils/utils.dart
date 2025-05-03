String maskPhoneNumber(String text) {
  final len = text.length;
  final prefix = text.substring(0, 3);
  final suffix = text.substring(len - 2, len);
  final mask = '*' * (len - prefix.length - suffix.length);
  return '$prefix$mask$suffix';
}

String maskEmailAddress(String text) {
  final parts = text.split('@');
  final len = parts.first.length;
  final prefix = parts.first.substring(0, 3);
  final suffix = parts.first.substring(len - 2, len);
  return '$prefix***$suffix@${parts.last}';
}
