import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/router.dart';
import '../delivery_issues/page.dart';
import 'components/bottom_sheet.dart';

final dashboardPageProvider =
    AutoDisposeNotifierProvider<_Notifier, int>(_Notifier.new);

class _Notifier extends AutoDisposeNotifier<int> {
  @override
  int build() => 0;

  void updatePageIndex(int value, [BuildContext? context]) {
    if (value == 3) return _showSupportBottomSheet(context!).ignore();
    state = value;
  }

  Future<void> _showSupportBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<bool?>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const SupportBottomSheetContent(),
    );

    if (!context.mounted || result != true) return;

    pushNamed(context, DeliveryIssuesPage.routeName);
  }
}
