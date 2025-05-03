import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/extensions/num_duration.dart';
import '../../core/routers/app_routes.dart';
import '../../models/earning.dart';
import '../notifications/page.dart';
import '../withdraw_earnings/page.dart';

final earningsPageFutureProvider = FutureProvider<List<Earning>>((_) async {
  await 1.5.seconds.delayed;
  return List.generate(23, (index) {
    return Earning(
      id: 'id$index',
      name: 'Iya Moria',
      price: 1500,
      datetime: DateTime.now(),
      type: EarningType.credit,
    );
  });
});

final earningsPageProvider = Provider((_) => _Provider());

class _Provider {
  void onBellIcon(BuildContext context) =>
      pushNamed(context, NotificationsPage.routeName);

  void onWithdraw(BuildContext context) =>
      pushNamed(context, WithdrawEarningsPage.routeName);

  void onViewEarning(BuildContext context, Earning earning) {}
}
