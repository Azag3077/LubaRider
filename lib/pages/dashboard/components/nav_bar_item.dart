import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class CustomBottomNavigationBarItem extends BottomNavigationBarItem {
  CustomBottomNavigationBarItem({
    required String assetName,
    required bool selected,
    required super.label,
  }) : super(
          icon: Image.asset(
            assetName,
            color: selected ? AppColors.primary : null,
          ),
        );
}
