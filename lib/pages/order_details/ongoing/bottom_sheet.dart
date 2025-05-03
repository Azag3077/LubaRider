import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../models/order.dart';
import '../components/profile_tile.dart';
import 'provider.dart';

class OngoingBottomSheet extends ConsumerWidget {
  const OngoingBottomSheet(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(ongoingBottomSheetProvider);

    return Column(
      spacing: 12.0,
      children: <Widget>[
        /// The Info Container
        Row(
          spacing: 8.0,
          children: <Widget>[
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Pick up by 10 PM',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '4 items • 15 mins total',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: AppColors.hintColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              order.price.toPriceWithCurrency(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.yellow600,
                fontSize: 19.0,
              ),
            ),
          ],
        ),

        /// The Customer Details
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.greyOutline),
          ),
          child: OrderProfileTile(
            imageUrl: '',
            title: 'Customer',
            name: r'Damilola James',
            onCall: () => notifier.onCall(context, order),
          ),
        ),

        /// The Base Buttons Row
        FilledButton(
          onPressed: () => notifier.onIHaveArrived(context, order),
          child: const Center(child: Text('I have arrived')),
        ),
      ],
    );
  }
}
