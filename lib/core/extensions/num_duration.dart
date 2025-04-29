/// Credit to the author of [flutter_animate]
///
/// Adds extensions to num (ie. int & double) to make creating durations simple:
///
/// ```
/// 200.ms // equivalent to Duration(milliseconds: 200)
/// 3.seconds // equivalent to Duration(milliseconds: 3000)
/// 1.5.days // equivalent to Duration(hours: 36)
/// ```
extension NumDurationExtensions on num {
  Duration get microseconds => Duration(microseconds: round());

  Duration get ms => (this * 1000).microseconds;

  Duration get milliseconds => (this * 1000).microseconds;

  Duration get seconds => (this * 1000 * 1000).microseconds;

  Duration get minutes => (this * 1000 * 1000 * 60).microseconds;

  Duration get hours => (this * 1000 * 1000 * 60 * 60).microseconds;

  Duration get days => (this * 1000 * 1000 * 60 * 60 * 24).microseconds;

  Duration get years => (this * 1000 * 1000 * 60 * 60 * 24 * 365).microseconds;
}

extension DurationExt on Duration {
  Future<void> get delayed async => await Future.delayed(this);
}

extension NumExtension on num {
  String toPriceWithCurrency({String currency = '₦', int dp = 0}) {
    final regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final parts = toStringAsFixed(dp).split('.');
    final intPart =
        parts[0].replaceAllMapped(regex, (Match match) => '${match[1]},');

    if (parts.length == 1) return currency + intPart;

    return '$currency$intPart.${parts[1]}';
  }

  String formatDistance({bool includeAway = true}) {
    String suffix = includeAway ? ' away' : '';

    if (this < 1.0) {
      final meters = (this * 1000).round();
      return '${_format(meters)} m$suffix';
    } else if (this < 1000) {
      return '${_format(this)} km$suffix';
    } else if (this < 1000000) {
      final k = (this / 1000);
      return '${_format(k)}k km$suffix';
    } else {
      final m = (this / 1000000);
      return '${_format(m)}M km$suffix';
    }
  }

  String _format(num value) {
    final n = value.toStringAsFixed(1);
    final parts = n.split('.');

    if (int.parse(parts.last) > 0) return n;

    return parts.first;
  }
}
