import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/num_duration.dart';
import '../../../models/order.dart';

final pendingOrderFutureProvider = FutureProvider<List<Order>>((_) async {
  await 1.5.seconds.delayed;
  return List.generate(23, (index) {
    return Order(
      id: 'id$index',
      username: 'Iya Moria',
      location: r'UNILAG',
      address: r'Yaba road, idi araba street',
      distanceInKm: 2.2,
      price: 1500,
      status: OrderStatus.pending,
    );
  });
});
