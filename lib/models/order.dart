class Order {
  const Order({
    required this.id,
    required this.username,
    required this.location,
    required this.address,
    required this.distanceInKm,
    required this.price,
    required this.status,
  });

  final String id;
  final String username;
  final String location;
  final String address;
  final num distanceInKm;
  final num price;
  final OrderStatus status;
}

enum OrderStatus {
  pending,
  ongoing,
  canceled,
  completed;

  bool get isPending => this == pending;

  bool get isOngoing => this == ongoing;

  bool get isCanceled => this == canceled;

  bool get isCompleted => this == completed;
}
