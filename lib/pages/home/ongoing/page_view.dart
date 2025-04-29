import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/place_holders.dart';
import '../../../core/constants/colors.dart';
import '../components/card.dart';
import '../../../components/no_order_page.dart';
import '../provider.dart';
import 'provider.dart';

class OngoingPageView extends ConsumerWidget {
  const OngoingPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(ongoingOrderFutureProvider);
    final notifier = ref.read(homePageProvider.notifier);

    return asyncValue.when(
      error: (error, stackTrace) {
        return Column(
          spacing: 8.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('An error as occurred'),
            FilledButton(
              style: FilledButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: () => ref.refresh(ongoingOrderFutureProvider),
              child: const Text('Retry'),
            ),
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: CustomLoadingWidget(showBottom: false),
      ),
      data: (orders) {
        if (orders.isEmpty) return const NoOrderPage('No ongoing orders');

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, int index) {
            final order = orders.elementAt(index);
            return OrderCard(
              order: order,
              actionBtnText: 'Cancel delivery',
              actionBtnColor: AppColors.red400,
              onViewDetails: () => notifier.onViewDetails(context, order),
              onMainActionBnt: () => notifier.onAccept(context, order),
            );
          },
        );
      },
    );
  }
}
