import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/container.dart';

class DeliveryIssuesPage extends ConsumerWidget {
  const DeliveryIssuesPage({super.key});

  static const routeName = '/delivery-issues';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('Delivery issues')),
        body: Column(
          children: <Widget>[
            const TabBar(
              tabs: <Widget>[
                Tab(text: 'Ongoing'),
                Tab(text: 'Completed'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: List.generate(2, (_) {
                  return ListView.separated(
                    itemCount: 12,
                    separatorBuilder: (_, __) => const Divider(height: 0),
                    itemBuilder: (context, int index) {
                      return const DeliveryIssuesContainer();
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
