import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../models/order.dart';
import '../components/stepper.dart';
import 'provider.dart';

class PendingBottomSheet extends ConsumerWidget {
  const PendingBottomSheet(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(pendingBottomSheetProvider);

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
                    'Delivered by 3:00pm',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: AppColors.secText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Pizza Hut',
                    style: TextStyle(
                      fontSize: 14.0,
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
            SizedBox.square(
              dimension: 48.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 5.0,
                    color: const Color(0xFFFF272B),
                  ),
                ),
                child: const Center(
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.stopwatch,
                          size: 10.0,
                          color: AppColors.secText,
                        ),
                        Text(
                          '15s',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        /// Pickup & Deliver Address
        const PickupDeliverAddress(
          currentIndex: -1,
          addresses: <AddressInfo>[
            AddressInfo(
              icon: ImageAssetNames.checkmarkFill,
              title: 'Pickup',
              address: r'G95 barkisu iyede St, '
                  r'Onike Lagos 1012344, Lagos, Nigeria',
              distanceInKm: 2.3,
            ),
            AddressInfo(
              icon: ImageAssetNames.locationCheck,
              title: 'Deliver',
              address: r'G95 barkisu iyede St, '
                  r'Onike Lagos 1012344, Lagos, Nigeria',
              distanceInKm: 2.3,
            ),
          ],
        ),

        /// The Hint & Price Row
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: AppColors.containerFg,
          ),
          child: Row(
            spacing: 8.0,
            children: <Widget>[
              const Expanded(
                child: Text(
                  'includes order pay and customer tip (Total may be high)',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                    color: AppColors.secText,
                  ),
                ),
              ),
              Text(
                1500.toPriceWithCurrency(),
                style: const TextStyle(
                  fontSize: 19.0,
                  color: AppColors.yellow600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        /// The Base Buttons Row
        Row(
          spacing: 8.0,
          children: <Widget>[
            IconButton(
              onPressed: () => notifier.onCancel(context, order),
              style: IconButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.red400,
                padding: const EdgeInsets.all(12.0),
              ),
              icon: const Icon(Icons.close),
            ),
            Expanded(
              child: FilledButton(
                onPressed: () => notifier.onAccept(context, order),
                child: const Center(child: Text('Accept delivery')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
