import 'package:flutter/material.dart';

class PageViewContent extends StatelessWidget {
  const PageViewContent({
    super.key,
    required this.assetName,
    required this.title,
    required this.subtitle,
  });

  final String assetName;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        Image.asset(assetName),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
