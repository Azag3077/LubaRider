import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../core/extensions/num_duration.dart';
import '../../core/extensions/string.dart';
import '../../models/delivery.dart';
import '../order_details/components/stepper.dart';
import 'provider.dart';

class DeliveryOrderDetailsPage extends ConsumerWidget {
  const DeliveryOrderDetailsPage(this.delivery, {super.key});

  final Delivery delivery;

  static const routeName = '/delivery-order-details';

  Widget _priceText(num price) {
    return Text(
      price.toPriceWithCurrency(),
      style: const TextStyle(
        fontSize: 13.0,
        color: Color(0xFF249524),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      spacing: 4.0,
      children: <Widget>[
        Icon(
          icon,
          size: 16.0,
          color: AppColors.hintColor,
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.hintColor,
            fontSize: 13.0,
          ),
        ),
      ],
    );
  }

  Widget _buildIconTextWithSubtext({
    required IconData icon,
    required String text,
    required String subtext,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildIconText(icon, text),
        Text(
          subtext,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13.0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(deliveryOrderDetailsPageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order ${delivery.orderId}'),
        actions: <Widget>[
          Text(
            delivery.status.name.title,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: delivery.status.isCompleted
                  ? AppColors.green600
                  : AppColors.red500,
            ),
          ),
          const SizedBox(width: 12.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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

            const SizedBox(height: 16.0),

            const Text(
              '1st Pack',
              style: TextStyle(
                fontSize: 13.0,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            /// First Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Berry Blast X 1',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _priceText(15000),
              ],
            ),
            const Text(
              '1 bottle of 5 Alive Berry Blast',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11.0,
                color: AppColors.hintColor,
              ),
            ),

            const SizedBox(height: 16.0),

            /// Second Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  r'MINI SHAWARMA - Chicken X 1',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _priceText(15000),
              ],
            ),
            const Text(
              'A delicious wrap filled with tender '
              'chicken or meat chunks, Crisp vegetables and '
              'a savory hot dog, all drilled with our special sauce. '
              'Perfectly portable and packed with flavour',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 11.0,
                color: AppColors.hintColor,
              ),
            ),

            const SizedBox(height: 16.0),

            /// Total Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Total Price',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _priceText(25000),
              ],
            ),

            const SizedBox(height: 16.0),

            /// Distance & Time Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildIconTextWithSubtext(
                  icon: CupertinoIcons.map,
                  text: 'Distance',
                  subtext: 2.3.formatDistance(includeAway: false),
                ),
                _buildIconTextWithSubtext(
                  icon: CupertinoIcons.stopwatch,
                  text: 'Time',
                  subtext: '0.00 Mins',
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            _buildIconText(
              CupertinoIcons.square_stack_3d_up_fill,
              'Amount Gathered',
            ),
            _priceText(1000),
            const SizedBox(height: 16.0),

            _buildIconText(Icons.calendar_month, 'Data'),
            const Text('February 12th 2025 07:30 PM'),

            const SizedBox(height: 48.0),
            Row(
              spacing: 8.0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (delivery.status.isCompleted) ...[
                  Image.asset(ImageAssetNames.like),
                  const Text(
                    'You rated this delivery',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.green500,
                    ),
                  ),
                ] else
                  const Text(
                    'No rating',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  )
              ],
            ),
            const SizedBox(height: 24.0),
            CustomPaint(
              size: const Size(double.infinity, 0),
              painter: DashedLinePainter(),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    this.color = const Color(0xFFB0B0B0),
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
