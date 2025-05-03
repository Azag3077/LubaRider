import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/extensions/datetime.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../models/earning.dart';

class EarningListTile extends StatelessWidget {
  const EarningListTile({
    super.key,
    required this.earning,
    required this.onTap,
  });

  final Earning earning;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(earning.id),
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.containerFg,
        ),
        child: earning.type.isCredit
            ? const Icon(
                size: 18.0,
                CupertinoIcons.down_arrow,
                color: AppColors.green600,
              )
            : const Icon(
                size: 18.0,
                CupertinoIcons.up_arrow,
                color: AppColors.red500,
              ),
      ),
      title: Text(
        earning.name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.text,
          fontSize: 13.0,
        ),
      ),
      subtitle: Text(
        earning.datetime.toMonDayAndTime,
        style: const TextStyle(
          color: AppColors.secText,
          fontWeight: FontWeight.w500,
          fontSize: 10.0,
        ),
      ),
      trailing: Text(
        '${earning.type.isCredit ? '+' : '-'}'
        '${earning.price.toPriceWithCurrency()}',
        style: TextStyle(
          color: earning.type.isCredit ? AppColors.green600 : AppColors.red500,
          fontWeight: FontWeight.bold,
          fontSize: 13.0,
        ),
      ),
      visualDensity: VisualDensity.compact,
    );
  }
}
