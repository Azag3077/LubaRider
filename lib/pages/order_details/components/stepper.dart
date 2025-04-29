import 'package:flutter/material.dart';

import '../../../components/chip.dart';
import '../../../core/constants/colors.dart';

class StepperDivider extends StatelessWidget {
  const StepperDivider({
    super.key,
    required this.icon,
    required this.value,
    this.start = false,
    this.end = false,
  });

  final String icon;
  final bool value;
  final bool start;
  final bool end;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (start)
          const SizedBox(height: 8.0)
        else
          const SizedBox(
            height: 8.0,
            child: VerticalDivider(
              color: AppColors.yellow500,
              thickness: 2.0,
            ),
          ),
        Image.asset(icon),
        Expanded(
          child: VerticalDivider(
            endIndent: end ? 6.0 : 0,
            color: AppColors.yellow500,
            thickness: 2.0,
          ),
        ),
        if (end)
          const SizedBox(
            width: 18.0,
            child: Divider(
              thickness: 2.0,
              height: 0,
            ),
          ),
      ],
    );
  }
}

class PickupDeliverAddress extends StatelessWidget {
  const PickupDeliverAddress({
    super.key,
    required this.addresses,
    this.currentIndex = 0,
  });

  final List<AddressInfo> addresses;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: addresses.asMap().entries.map((entry) {
        final index = entry.key;
        final end = index == addresses.length - 1;
        final value = currentIndex >= index;
        final info = entry.value;

        return IntrinsicHeight(
          child: Row(
            spacing: 8.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0.0 : 0),
                child: StepperDivider(
                  value: value,
                  start: index == 0,
                  end: end,
                  icon: info.icon,
                ),
              ),
              Expanded(
                child: ListTile(
                  // visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  title: Text(
                    info.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.text,
                      fontSize: 13.0,
                    ),
                  ),
                  subtitle: Text(
                    info.address,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.hintColor,
                      fontSize: 11.0,
                    ),
                  ),
                  trailing: DistanceChip(info.distanceInKm),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class AddressInfo {
  const AddressInfo({
    required this.icon,
    required this.title,
    required this.address,
    required this.distanceInKm,
  });

  final String icon;
  final String title;
  final String address;
  final num distanceInKm;
}
