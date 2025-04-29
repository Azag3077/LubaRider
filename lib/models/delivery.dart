class Delivery {
  const Delivery({
    required this.id,
    required this.orderId,
    required this.datetime,
    required this.status,
  });

  final String id;
  final String orderId;
  final DateTime datetime;
  final DeliveryStatus status;
}

enum DeliveryStatus {
  completed('Completed Orders'),
  cancelled('Cancelled Orders');

  final String label;

  const DeliveryStatus(this.label);

  bool get isCompleted => this == completed;

  bool get isCancelled => this == cancelled;
}
