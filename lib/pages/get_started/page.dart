import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import 'provider.dart';

class GetStartedPage extends ConsumerWidget {
  const GetStartedPage({super.key});

  static const routeName = '/get-started';

  Widget _buildFilledButton({
    required String text,
    required VoidCallback onPressed,
    Color? bgColor,
    Color? fgColor,
  }) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Center(child: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(getStartedProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 56.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssetNames.getStartedBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Text(
              'Fast, Reliable Package Delivery',
              style: TextStyle(
                fontSize: 34.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Choose when you want to work, earn cash bonuses and many more',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox.shrink(),
            _buildFilledButton(
              text: 'Sign up as a New Rider',
              onPressed: () => notifier.onSignUpAsANewRider(context),
            ),
            _buildFilledButton(
              text: 'Log in as existing Rider',
              bgColor: Colors.white,
              fgColor: AppColors.primary,
              onPressed: () => notifier.onLogIn(context),
            ),
          ],
        ),
      ),
    );
  }
}
