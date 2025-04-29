import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routers/app_routes.dart';
import '../../../models/order.dart';
import '../../delivery_complete/page.dart';

final ongoingBottomSheetProvider = Provider((ref) => _Provider(ref));

class _Provider {
  _Provider(this._ref);

  final Ref _ref;

  void onCall(BuildContext context, Order order) {}

  void onIHaveArrived(BuildContext context, Order order) =>
      pushNamed(context, DeliveryCompletePage.routeName, arguments: order);
}
