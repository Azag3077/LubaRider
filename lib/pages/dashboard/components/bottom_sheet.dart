import 'package:flutter/material.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/routers/router.dart';

class SupportBottomSheetContent extends StatelessWidget {
  const SupportBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Support',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CloseButton(
                  onPressed: () => pop(context, false),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.greyOutline,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                spacing: 16.0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(ImageAssetNames.contactSupport),
                  const Text(
                    'Start a conversation with our team of experts now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Report anything wrong with an order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FilledButton(
                    onPressed: () => pop(context, true),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    ),
                    child: const Text('New conversation'),
                  ),
                  const SizedBox(height: 48.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
