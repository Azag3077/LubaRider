import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/image_picker.dart';
import 'provider.dart';

class VerifyIdentityPageView extends ConsumerWidget {
  const VerifyIdentityPageView({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verificationDetailsPageViewProvider);
    final notifier = ref.read(verificationDetailsPageViewProvider.notifier);

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Verify Identity',
                style: textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.all(16.0 + 24.0),
              child: LayoutBuilder(builder: (context, constraints) {
                final dimension = min(constraints.maxWidth, 248.0);

                return CustomPaint(
                  painter: DottedBorderPainter(
                    radius: dimension / 2,
                    strokeWidth: 24.0,
                    dashWidth: 6.0,
                    gap: 6.0,
                    drawInside: false,
                    color: const Color(0xFF37A010),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(dimension / 2),
                    child: SizedBox.square(
                      dimension: dimension,
                      child: const ColoredBox(color: Colors.black),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Position your bare face clearly in the camera. No face mask or glasses',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => notifier.onFinishRegistration(context),
              child: const Center(child: Text('Finish Registration')),
            ),
            TextButton(
              onPressed: () => notifier.onRetakePhoto(context),
              child: const Text('Retake photo'),
            ),
          ],
        ),
      ),
    );
  }
}
