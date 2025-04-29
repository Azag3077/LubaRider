import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../../models/issue.dart';
import '../report_details/page.dart';

final reportPageProvider =
    AutoDisposeNotifierProvider<_Notifier, DeliveryIssue?>(_Notifier.new);

class _Notifier extends AutoDisposeNotifier<DeliveryIssue?> {
  @override
  DeliveryIssue? build() => null;

  void updateState(DeliveryIssue deliveryIssue) => state = deliveryIssue;

  Future<void> onProceed(BuildContext context) =>
      pushNamed(context, ReportDetailsPage.routeName, arguments: state);
}
