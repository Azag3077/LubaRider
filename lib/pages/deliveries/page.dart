import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/place_holders.dart';
import '../../core/constants/colors.dart';
import '../../models/delivery.dart';
import '../../components/no_order_page.dart';
import 'components/list_tile.dart';
import 'provider.dart';

class DeliveriesPage extends ConsumerWidget {
  const DeliveriesPage({super.key});

  static const routeName = '/deliveries';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: DeliveryStatus.values.length,
      child: Scaffold(
        appBar: AppBar(title: const Text('Deliveries')),
        body: Column(
          children: <Widget>[
            TabBar(
              tabs: DeliveryStatus.values
                  .map((status) => Tab(text: status.label))
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                children: DeliveryStatus.values.map((status) {
                  final asyncValue =
                      ref.watch(deliveriesPageFutureProvider(status));
                  final notifier =
                      ref.read(deliveriesPageFutureProvider(status).notifier);

                  return asyncValue.when(
                    loading: () => const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CustomLoadingWidget(showBottom: false),
                    ),
                    error: (error, stackTrace) {
                      return Column(
                        spacing: 8.0,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'An error occurred, please try again later.',
                          ),
                          FilledButton(
                            onPressed: () => ref.refresh(
                                deliveriesPageFutureProvider(status).notifier),
                            child: const Text('Retry'),
                          ),
                        ],
                      );
                    },
                    data: (data) {
                      if (data.isEmpty) {
                        return NoOrderPage('No ${status.name} delivery yet');
                      }
                      return RefreshIndicator(
                        onRefresh: () => ref.refresh(
                            deliveriesPageFutureProvider(status).future),
                        child: ListView.separated(
                          itemCount: data.length,
                          separatorBuilder: (_, __) => const Divider(
                            color: AppColors.greyOutline,
                            height: 0,
                            indent: 12.0,
                            endIndent: 12.0,
                          ),
                          itemBuilder: (context, int index) {
                            final delivery = data.elementAt(index);

                            return DeliveryListTile(
                              onTap: () => notifier.onTap(context, delivery),
                              delivery: delivery,
                            );
                          },
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
