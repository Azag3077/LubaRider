import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../../models/delivery.dart';
import '../delivery_order_details/page.dart';

final deliveryOrderDetailsPageProvider = Provider((_) => _Provider());

class _Provider {
  void onTap(BuildContext context, Delivery delivery) =>
      pushNamed(context, DeliveryOrderDetailsPage.routeName);
}
