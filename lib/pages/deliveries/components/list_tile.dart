import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/extensions/datetime.dart';
import '../../../models/delivery.dart';

class DeliveryListTile extends StatelessWidget {
  const DeliveryListTile({
    super.key,
    required this.delivery,
    required this.onTap,
  });

  final Delivery delivery;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              delivery.status.isCompleted ? AppColors.green50 : AppColors.red50,
        ),
        child: Image.asset(
          width: 15.0,
          ImageAssetNames.deliveries,
          color: delivery.status.isCompleted
              ? AppColors.green600
              : AppColors.red500,
        ),
      ),
      title: Text(
        'Order ${delivery.orderId}',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.text,
          fontSize: 13.0,
        ),
      ),
      subtitle: Text(
        delivery.datetime.toMonDayAndTime,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.hintColor,
          fontSize: 11.0,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_right_alt,
        color: AppColors.hintColor,
      ),
    );
  }
}
