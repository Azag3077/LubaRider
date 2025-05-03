import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/constants/assets.dart';

class NoOrderPage extends StatelessWidget {
  const NoOrderPage(
    this.text, {
    super.key,
    this.image = ImageAssetNames.redBike,
  });

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(image)
              .animate(onPlay: (ctrl) => ctrl.repeat(reverse: true))
              .move(
                duration: 1.5.seconds,
                begin: Offset.zero,
                end: const Offset(0, -8),
                curve: Curves.easeInOut,
              ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
            ),
          ),
          const SizedBox(height: 80.0),
        ],
      ),
    );
  }
}
