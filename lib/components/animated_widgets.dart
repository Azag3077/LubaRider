import 'package:flutter/material.dart';

import '../core/extensions/num_duration.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  const CustomAnimatedSwitcher({
    super.key,
    required this.value,
    required this.child,
  });

  final bool value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: 300.ms,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
      child: value
          ? SizedBox(
              key: ValueKey<bool>(value),
              child: child,
            )
          : SizedBox.shrink(key: ValueKey<bool>(value)),
    );
  }
}
