import 'package:intl/intl.dart';

extension DatetimeUtils on DateTime {
  String toStr([String format = 'EEE, dd MMM yyyy']) =>
      DateFormat(format).format(this);

  String get toMonDayAndTime => DateFormat('MMM dd, hh:mm aaa').format(this);
  String get toTimeStr => DateFormat('hh:mma').format(this);
}
