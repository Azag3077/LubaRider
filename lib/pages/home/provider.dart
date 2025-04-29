import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/extensions/num_duration.dart';
import '../../core/routers/app_routes.dart';
import '../../models/order.dart';
import '../order_details/page.dart';
import '../notifications/page.dart';

final homePageProvider = NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.page = 0.0,
    this.index = 0,
  });

  final double page;
  final int index;

  _State copyWith({
    double? page,
    int? index,
  }) {
    return _State(
      page: page ?? this.page,
      index: index ?? this.index,
    );
  }
}

class _Notifier extends Notifier<_State> {
  @override
  _State build() => const _State();

  void onTabSwitch(PageController controller, int index) {
    onPageChanged(index);
    controller.animateToPage(index, duration: 200.ms, curve: Curves.linear);
  }

  void onPageChanged(int index) => state = state.copyWith(index: index);

  void updatePage(double value) => state = state.copyWith(page: value);

  void onBellIcon(BuildContext context) =>
      pushNamed(context, NotificationsPage.routeName);

  void onViewDetails(BuildContext context, Order order) =>
      pushNamed(context, OrderDetailsPage.routeName, arguments: order);

  void onAccept(BuildContext context, Order order) {}

  void onCancel(BuildContext context, Order order) {}
}
