import 'package:flutter/material.dart';

import '../../../components/chip.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../models/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.actionBtnText,
    this.actionBtnColor,
    required this.onViewDetails,
    required this.onMainActionBnt,
  });

  final Order order;
  final String actionBtnText;
  final Color? actionBtnColor;
  final VoidCallback onViewDetails;
  final VoidCallback onMainActionBnt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        spacing: 12.0,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${order.username} - ${order.location}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
              DistanceChip(order.distanceInKm),
            ],
          ),
          Row(
            children: <Widget>[
              Image.asset(
                ImageAssetNames.location,
                color: AppColors.secText,
                width: 16.0,
              ),
              const SizedBox(width: 4.0),
              Text(
                order.address,
                style: const TextStyle(
                  fontSize: 11.0,
                  color: AppColors.secText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                order.price.toPriceWithCurrency(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColors.yellow600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            spacing: 8.0,
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  onPressed: onViewDetails,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: AppColors.greyOutline,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kButtonRadius),
                    ),
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                    ),
                  ),
                  child: const Text('View details'),
                ),
              ),
              Expanded(
                child: FilledButton(
                  onPressed: onMainActionBnt,
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: actionBtnColor,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                    ),
                  ),
                  child: Text(actionBtnText),
                ),
              ),
            ],
          ),
          const Divider(
            color: AppColors.greyOutline,
            height: 4.0,
          ),
        ],
      ),
    );
  }
}
