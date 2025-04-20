extension DurationExtensions on Duration {
  String toStr() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String hours = twoDigits(inHours);
    String minutes = twoDigits(inMinutes.remainder(60));
    String seconds = twoDigits(inSeconds.remainder(60));

    return '${int.parse(hours) > 1 ? '$hours:' : ''}$minutes:$seconds';
  }

  String toFormattedString([String? suffix = 'away']) {
    final weeks = inDays ~/ 7;
    final days = inDays.remainder(7);
    final hours = inHours.remainder(24);
    final minutes = inMinutes.remainder(60);

    final parts = [];
    if (weeks > 0) parts.add('$weeks week${weeks > 1 ? 's' : ''}');
    if (days > 0) parts.add('$days day${days > 1 ? 's' : ''}');
    if (hours > 0) parts.add('$hours hr${hours > 1 ? 's' : ''}');
    if (minutes > 0) parts.add('$minutes min${minutes > 1 ? 's' : ''}');

    return '${parts.join(' ')}${suffix == null ? '' : ' $suffix'}';
  }
}
