import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.length,
  });

  final int currentIndex;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2.0,
      children: <Widget>[
        ...List.generate(length, (index) {
          final color =
              currentIndex >= index ? AppColors.primary : AppColors.greyOutline;

          final dot = SizedBox.square(
            dimension: 6.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          );

          return Expanded(
            child: Row(
              spacing: 2.0,
              children: <Widget>[
                dot,
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.5),
                    child: Divider(thickness: 3.0, color: color),
                  ),
                ),
                if (index + 1 == length) dot,
              ],
            ),
          );
        }),
      ],
    );
  }
}
