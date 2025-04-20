import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.onPressed,
    required this.imageAssetName,
    required this.text,
    required this.bgColor,
  });

  final VoidCallback onPressed;
  final String imageAssetName;
  final String text;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      highlightElevation: 0,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        spacing: 8.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imageAssetName),
          Text(text),
        ],
      ),
    );
  }
}
