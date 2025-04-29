import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../models/order.dart';
import '../order_details/components/profile_tile.dart';
import 'provider.dart';

class DeliveryCompletePage extends ConsumerWidget {
  const DeliveryCompletePage(this.order, {super.key});

  final Order order;

  static const routeName = '/delivery-complete';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(deliveryCompletePageProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                spacing: 12.0,
                children: <Widget>[
                  Image.asset(ImageAssetNames.doubleCheckmark, height: 124.0)
                      .animate()
                      .scale(curve: Curves.elasticOut, duration: 1000.ms)
                      .fadeIn(duration: 500.ms),
                  const Text(
                    'Delivery Completed',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slide(
                        begin: const Offset(0, 0.3),
                        end: const Offset(0, 0),
                        curve: Curves.easeOut,
                        duration: 800.ms,
                      ),
                  const Text(
                    'Ask the customer to confirm '
                    'this code before handing over the package',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secText,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slide(
                        begin: const Offset(0, 0.3),
                        end: const Offset(0, 0),
                        curve: Curves.easeOut,
                        duration: 800.ms,
                      ),

                  /// Customer OTP Container
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green50,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.greyOutline),
                    ),
                    child: const Column(
                      children: <Widget>[
                        Text(
                          'Customer OTP',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                            fontSize: 13.0,
                          ),
                        ),
                        Text(
                          '8782',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// The Customer Details
                  Container(
                    margin: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.greyOutline),
                    ),
                    child: Column(
                      spacing: 8.0,
                      children: <Widget>[
                        OrderProfileTile(
                          imageUrl: '',
                          title: 'Customer',
                          name: r'Damilola James',
                          onCall: () => notifier.onCallUser1(context, order),
                        ),
                        const Divider(height: 0),
                        OrderProfileTile(
                          imageUrl: '',
                          radius: 6.0,
                          title: 'Restaurant',
                          name: r'Cheezys, Yabatech',
                          onCall: () => notifier.onCallUser2(context, order),
                        ),
                      ],
                    ),
                  ),

                  MaterialButton(
                    onPressed: () => notifier.onReportIssue(context, order),
                    elevation: 0,
                    highlightElevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 23.0,
                      vertical: 15.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    color: AppColors.red50,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Report issue',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.error,
                            fontSize: 14.0,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: AppColors.error,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            /// The Base Buttons Row
            FilledButton(
              onPressed: () => notifier.onCompleteOrder(context, order),
              child: const Center(child: Text('Complete Order')),
            ),
          ],
        ),
      ),
    );
  }
}
