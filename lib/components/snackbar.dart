import 'package:flutter/material.dart';

import '../core/extensions/num_duration.dart';

enum SnackbarType { success, info, warning, error }

Color _getBgColor(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return const Color(0xFFF8FFFB);
    case SnackbarType.info:
      return const Color(0xFFF2F8FF);
    case SnackbarType.warning:
      return const Color(0xFFFFFBF3);
    case SnackbarType.error:
      return const Color(0xFFFFF6F6);
  }
}

Color _getBorderColor(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return const Color(0xFFCBE1D4);
    case SnackbarType.info:
      return const Color(0xFFC2DAF4);
    case SnackbarType.warning:
      return const Color(0xFFEFDDBE);
    case SnackbarType.error:
      return const Color(0xFFE8BEBD);
  }
}

Color _getIconColor(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return const Color(0xFF04802E);
    case SnackbarType.info:
      return const Color(0xFF0D5EBA);
    case SnackbarType.warning:
      return const Color(0xFFDD900D);
    case SnackbarType.error:
      return const Color(0xFFCB1A14);
  }
}

Color _getIconBgColor(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return const Color(0xFFE7F6EC);
    case SnackbarType.info:
      return const Color(0xFFE3EFFC);
    case SnackbarType.warning:
      return const Color(0xFFFEF6E7);
    case SnackbarType.error:
      return const Color(0xFFFBEAE9);
  }
}

Color _getIconBorderColor(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return const Color(0xFFB5E3C4);
    case SnackbarType.info:
      return const Color(0xFFC6DDF7);
    case SnackbarType.warning:
      return const Color(0xFFFBE2B7);
    case SnackbarType.error:
      return const Color(0xFFF2BCBA);
  }
}

IconData _getIconData(SnackbarType type) {
  switch (type) {
    case SnackbarType.success:
      return Icons.check_circle;
    case SnackbarType.info:
      return Icons.info;
    case SnackbarType.warning:
      return Icons.warning;
    case SnackbarType.error:
      return Icons.error;
  }
}

void showSnackbar({
  required BuildContext context,
  required String title,
  String? subtitle,
  required SnackbarType type,
}) {
  const radius = 8.0;
  late OverlayEntry overlayEntry;
  final overlay = Overlay.of(context);

  overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        bottom: 32,
        left: 20,
        right: 20,
        child: TweenAnimationBuilder(
          duration: 500.ms,
          curve: Curves.easeOut,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double opacity, child) {
            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(0, (1 - opacity) * 30),
                child: Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 4.0,
                            decoration: BoxDecoration(
                              color: _getIconColor(type),
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(radius),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                12.0,
                                12.0,
                                6.0,
                                12.0,
                              ),
                              decoration: BoxDecoration(
                                color: _getBgColor(type),
                                border:
                                    Border.all(color: _getBorderColor(type)),
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(radius),
                                ),
                              ),
                              child: Row(
                                spacing: 12.0,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: _getIconBgColor(type),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          color: _getIconBorderColor(type)),
                                    ),
                                    child: Icon(
                                      _getIconData(type),
                                      size: 16.0,
                                      color: _getIconColor(type),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0XFF101928),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (subtitle != null)
                                          Text(
                                            subtitle,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF475367),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: overlayEntry.remove,
                                    style: IconButton.styleFrom(
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    iconSize: 20.0,
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );

  overlay.insert(overlayEntry);
  Future.delayed(3.seconds, () {
    if (overlayEntry.mounted) overlayEntry.remove();
  });
}
