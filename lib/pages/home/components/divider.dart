import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class DashDivider extends StatelessWidget {
  const DashDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomPaint(
        painter: DashPainter(),
      ),
    );
  }
}

class DashPainter extends CustomPainter {
  DashPainter({
    super.repaint,
    this.gap = 7.0,
    this.dashWidth = 8.0,
    this.stokeWidth = 2.0,
    this.color = AppColors.containerBg,
  });

  final double gap;
  final double dashWidth;
  final double stokeWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = stokeWidth;
    const dy = -10.0;

    for (double i = 0.0; i < size.width; i = i + gap + dashWidth) {
      final p1 = Offset(i, dy);
      final p2 = Offset(i + dashWidth, dy);

      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
