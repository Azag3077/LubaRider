import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/place_holders.dart';
import '../../../core/constants/colors.dart';

class OrderProfileTile extends StatelessWidget {
  const OrderProfileTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.name,
    required this.onCall,
    this.radius,
  });

  final String imageUrl;
  final String title;
  final String name;
  final double? radius;
  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: <Widget>[
        ImageLoader(
          imageUrl,
          width: 48.0,
          height: 48.0,
          radius: radius ?? 32.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: AppColors.secText,
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onCall,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.containerBg1,
            foregroundColor: Colors.white,
            iconSize: 18.0,
          ),
          icon: const Icon(CupertinoIcons.phone),
        ),
      ],
    );
  }
}
