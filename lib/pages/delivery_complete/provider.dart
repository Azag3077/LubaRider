import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../../models/order.dart';
import '../dashboard/page.dart';
import '../report/page.dart';

final deliveryCompletePageProvider = Provider((_) => _Provider());

class _Provider {
  void onCallUser1(BuildContext context, Order order) {}

  void onCallUser2(BuildContext context, Order order) {}

  void onReportIssue(BuildContext context, Order order) =>
      pushNamed(context, ReportPage.routeName);

  void onCompleteOrder(BuildContext context, Order order) =>
      popUntil(context, DashboardPage.routeName);
}
