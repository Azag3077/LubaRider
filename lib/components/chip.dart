import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/extensions/num_duration.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.onPressed,
    required this.text,
    required this.iconData,
  });

  final VoidCallback onPressed;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 12.0,
      ),
      labelPadding: const EdgeInsets.only(left: 6.0, right: 4.0),
      visualDensity: const VisualDensity(
        vertical: -4,
        horizontal: -4,
      ),
      avatar: Icon(iconData),
      backgroundColor: Colors.white,
      label: Text(text),
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 11.0,
      ),
      onPressed: onPressed,
    );
  }
}

class DistanceChip extends StatelessWidget {
  const DistanceChip(this.distanceInKm, {super.key});

  final num distanceInKm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: AppColors.greyOutline),
      ),
      child: Row(
        spacing: 5.0,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            size: 14.0,
            Icons.directions_bike,
            color: AppColors.secText,
          ),
          Text(
            distanceInKm.formatDistance(includeAway: false),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.secText,
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    );
  }
}
