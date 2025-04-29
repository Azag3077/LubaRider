import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/list_tile.dart';
import 'provider.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  static const routeName = '/notifications';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(notificationsPageProvider);
    final notifier = ref.read(notificationsPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: asyncValue.when(
        data: (data) {
          return RefreshIndicator(
            notificationPredicate: notifier.onNotificationPredicate,
            onRefresh: () async => await ref.refresh(notificationsPageProvider),
            child: ListView.separated(
              itemCount: 23,
              separatorBuilder: (_, __) =>
                  const Divider(height: 0, indent: 10.0, endIndent: 10.0),
              itemBuilder: (context, int index) {
                final notification = data.elementAt(index);
                return NotificationListTile(
                  notification: notification,
                  onTap: () => notifier.onTap(context, index),
                );
              },
            ),
          );
        },
        error: (e, __) => Center(
          child: Text('Error $e'),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
