import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/extensions/num_duration.dart';
import '../../core/routers/app_routes.dart';
import '../../models/delivery.dart';
import '../delivery_order_details/page.dart';

final deliveriesPageFutureProvider =
    AsyncNotifierProviderFamily<_Notifier, List<Delivery>, DeliveryStatus>(
        _Notifier.new);

class _Notifier extends FamilyAsyncNotifier<List<Delivery>, DeliveryStatus> {
  @override
  Future<List<Delivery>> build(DeliveryStatus status) async {
    await 1.5.seconds.delayed;
    return List.generate(23, (index) {
      return Delivery(
        id: 'id$index',
        orderId: '#${index}3${index}5${index}2',
        datetime: DateTime.now(),
        status: status,
      );
    });
  }

  void onTap(BuildContext context, Delivery delivery) =>
      pushNamed(context, DeliveryOrderDetailsPage.routeName,
          arguments: delivery);
}
