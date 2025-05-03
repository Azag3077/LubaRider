import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class FilterPopupButton extends StatelessWidget {
  const FilterPopupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
        side: const BorderSide(color: AppColors.greyOutline),
      ),
      child: const Row(
        spacing: 4.0,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'This Month',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.secText,
              fontSize: 13.0,
            ),
          ),
          Icon(
            size: 18.0,
            Icons.calendar_month,
            color: AppColors.hintColor,
          ),
        ],
      ),
    );
  }
}
