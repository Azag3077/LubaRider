import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/extensions/num_duration.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
    required this.pageValue,
    required this.currentIndex,
    required this.pendingCount,
    required this.ongoingCount,
    required this.onTabSwitch,
    required this.pendingTabKey,
    required this.ongoingTabKey,
  });

  final double pageValue;
  final int currentIndex;
  final int pendingCount;
  final int ongoingCount;
  final ValueChanged<int> onTabSwitch;

  final GlobalKey pendingTabKey;
  final GlobalKey ongoingTabKey;

  Widget _buildTabButton({
    required GlobalKey key,
    required String text,
    required int count,
    required int index,
  }) {
    final isSelected = index == currentIndex;

    return TweenAnimationBuilder(
      key: key,
      duration: 150.ms,
      tween: Tween<double>(
        begin: isSelected ? 0 : 1,
        end: isSelected ? 1 : 0,
      ),
      builder: (context, alpha, _) {
        return MaterialButton(
          onPressed: () => onTabSwitch(index),
          elevation: 0,
          highlightElevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          color: AppColors.textFieldBg.withValues(alpha: alpha),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 13.0,
              color: AppColors.containerFg,
              fontWeight: FontWeight.w600,
            ),
            child: Row(
              spacing: 6.0,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? AppColors.text : AppColors.containerFg,
                  ),
                ),
                SizedBox.square(
                  dimension: 20.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          isSelected ? AppColors.containerBg : AppColors.red400,
                    ),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          count.toString(),
                          style: const TextStyle(fontSize: 10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void azag() {
    final renderBox1 =
        ongoingTabKey.currentContext?.findRenderObject() as RenderBox?;
    final renderBox2 =
        ongoingTabKey.currentContext?.findRenderObject() as RenderBox?;
    final size1 = renderBox1?.size;
    final size2 = renderBox1?.size;
    print([size1, size2]);
  }

  @override
  Widget build(BuildContext context) {
    azag();
    print([ongoingTabKey, pageValue]);
    return Stack(
      children: <Widget>[
        // Positioned(
        //   // left: 12,
        //   // width: 80.0,
        //   // height: 48.0,
        //   child: Container(
        //     height: 48.0,
        //     width: 80,
        //     color: Colors.red,
        //   ),
        // ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: const Color(0xFF252A22),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildTabButton(
                key: pendingTabKey,
                index: 0,
                text: 'Pending',
                count: pendingCount,
              ),
              _buildTabButton(
                key: ongoingTabKey,
                index: 1,
                text: 'Ongoing',
                count: ongoingCount,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
