import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/place_holders.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../utils/utils.dart';
import 'provider.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  Widget _buildRow({
    required IconData icon,
    required String text,
    required String value,
    bool isVerified = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      child: Row(
        spacing: 4.0,
        children: <Widget>[
          Icon(
            icon,
            size: 18.0,
            color: AppColors.hintColor,
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.hintColor,
              fontSize: 13.0,
            ),
          ),
          Expanded(
            child: Row(
              spacing: 8.0,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (isVerified)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppColors.green50,
                    ),
                    child: const Text(
                      'Verified',
                      style: TextStyle(
                        color: AppColors.containerBg1,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(accountPageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: <Widget>[
          IconButton(
            onPressed: () => notifier.onSettings(context),
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.hintColor,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          /// Profile Container
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            color: AppColors.text,
            child: Row(
              spacing: 10.0,
              children: <Widget>[
                const ImageLoader(
                  '',
                  width: 48.0,
                  height: 48.0,
                  radius: 24.0,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        r'Oluwabode Micheal',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Rider ID: 4214124',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(ImageAssetNames.award3),
              ],
            ),
          ),
          const SizedBox(height: 8.0),

          ///
          _buildRow(
            icon: Icons.email_outlined,
            text: 'Email',
            value: maskEmailAddress('OluwabodeMicheal@gmail.com'),
            isVerified: true,
          ),
          _buildRow(
            icon: CupertinoIcons.phone,
            text: 'Phone Number',
            value: '08109755721',
          ),
          _buildRow(
            icon: Icons.location_on_outlined,
            text: 'Location',
            value: r'Ikeja',
          ),
          const SizedBox(height: 8.0),

          /// The Leaderboard Container
          MaterialButton(
            onPressed: () => notifier.onLeaderboard(context),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            elevation: 0,
            highlightElevation: 0,
            color: AppColors.containerFg,
            child: Row(
              spacing: 10.0,
              children: <Widget>[
                Image.asset(ImageAssetNames.star),
                const Expanded(
                  child: Column(
                    spacing: 4.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'View leaderboard',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        'See your current position against others',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.hintColor,
                  size: 18.0,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16.0),

          ///
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MaterialButton(
              onPressed: () => notifier.onBoostEarnings(context),
              padding: EdgeInsets.zero,
              color: AppColors.containerFg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(ImageAssetNames.accountCardEllipse),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 32.0, 8.0, 32.0),
                    child: Column(
                      spacing: 8.0,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Boost Your\nEarnings Today!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                          ),
                        ),
                        Text(
                          'Get Paid Instantly After\nEvery Delivery!',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.secText,
                            fontSize: 13.0,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Start Now',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                                fontSize: 13.0,
                              ),
                            ),
                            Icon(
                              size: 18.0,
                              Icons.arrow_forward,
                              color: AppColors.primary,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(ImageAssetNames.deliveryBike),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
