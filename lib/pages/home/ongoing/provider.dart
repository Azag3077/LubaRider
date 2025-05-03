import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/num_duration.dart';
import '../../../models/order.dart';

final uselessProvider = StateProvider<bool>((_) => false);

final ongoingOrderFutureProvider = FutureProvider<List<Order>>((ref) async {
  await 1.5.seconds.delayed;
  final useless = ref.watch(uselessProvider);
  return List.generate(useless ? 1 : 0, (index) {
    return Order(
      id: 'id$index',
      username: 'Iya Moria',
      location: r'UNILAG',
      address: r'Yaba road, idi araba street',
      distanceInKm: 2.2,
      price: 1500,
      status: OrderStatus.ongoing,
    );
  });
});
