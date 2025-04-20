import 'dart:ui';

import 'package:flutter/material.dart';

import 'spinner.dart';

class BlurryDialog extends StatelessWidget {
  const BlurryDialog({
    super.key,
    this.canPop = false,
    this.message,
  });

  final bool canPop;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);

    return PopScope(
      canPop: canPop,
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 16.0),
                      const AppSpinner(),
                      const SizedBox(height: 16.0),
                      Text(
                        message ?? 'Loading, please wait...',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showLoadingDialog(
  BuildContext context, {
  bool canPop = false,
  String? message,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlurryDialog(
        canPop: canPop,
        message: message,
      );
    },
  );
}
