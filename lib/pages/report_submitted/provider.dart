import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../dashboard/page.dart';
import '../delivery_issues/page.dart';

final reportSubmittedPageProvider = Provider((_) => _Provider());

class _Provider {
  void onViewIssue(BuildContext context) =>
      pushNamedAndRemoveUntil(context, DeliveryIssuesPage.routeName,
          until: DashboardPage.routeName);

  void onReturnToHome(BuildContext context) =>
      popUntil(context, DashboardPage.routeName);
}
