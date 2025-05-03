class Notification {
  const Notification({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.datetime,
  });

  final String id;
  final String title;
  final String subtitle;
  final DateTime datetime;
}
