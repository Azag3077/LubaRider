import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/notification.dart';

final notificationsPageProvider =
    AsyncNotifierProvider<_Notifier, List<Notification>>(_Notifier.new);

class _Notifier extends AsyncNotifier<List<Notification>> {
  @override
  Future<List<Notification>> build() async {
    final data = List.generate(23, (index) {
      return Notification(
        title: 'Notification title $index',
        subtitle: 'You have cancelled an order at Burger Hut. '
            'We apologize for our inconvenience, '
            'we will try to improve our service next time $index',
        datetime: DateTime.now(),
      );
    });
    await Future.delayed(2.seconds);

    return data;
  }

  bool onNotificationPredicate(ScrollNotification notification) => true;

  void onTap(BuildContext context, int index) {}
}
