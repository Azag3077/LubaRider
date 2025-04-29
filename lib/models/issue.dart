class DeliveryIssue {
  const DeliveryIssue({
    required this.title,
    required this.subIssues,
  });

  final String title;
  final List<String> subIssues;

  factory DeliveryIssue.fromJson(Map<String, dynamic> json) {
    return DeliveryIssue(
      title: json['title'] as String,
      subIssues: List<String>.from(json['subIssues'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subIssues': subIssues,
    };
  }
}
