import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../dashboard/provider.dart';
import 'components/bottom_sheet.dart';

final homePageProvider =
    AutoDisposeNotifierProvider<_Notifier, int>(_Notifier.new);

class _Notifier extends AutoDisposeNotifier<int> {
  @override
  int build() => 0;

  // void onLocation(BuildContext context) =>
  //     pushNamed(context, SearchLocationPage.routeName);
  //
  // void onBellIcon(BuildContext context) =>
  //     pushNamed(context, NotificationsPage.routeName);
  //
  // void onTapSearchField() =>
  //     ref.read(dashboardPageProvider.notifier).updatePageIndex(1);
  //
  // void onOrderFood(BuildContext context) =>
  //     pushNamed(context, SupermarketPage.routeName);
  //
  // void onGrocery(BuildContext context) =>
  //     pushNamed(context, SendPackagePage.routeName);
  //
  // void onPharmaceutical(BuildContext context) =>
  //     pushNamed(context, ReceivePackagePage.routeName);

  void onMore(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => const MoreServicesSheetContent(),
    );
  }

  // void onExpressDelivery(BuildContext context) =>
  //     pushReplacementNamed(context, ContactSupportPage.routeName);
  //
  // void onInternationalDelivery(BuildContext context) =>
  //     pushReplacementNamed(context, ContactSupportPage.routeName);
  //
  // void onInterstateDelivery(BuildContext context) =>
  //     pushReplacementNamed(context, ContactSupportPage.routeName);
  //
  // void onSupport(BuildContext context) =>
  //     pushReplacementNamed(context, ContactSupportPage.routeName);
}
