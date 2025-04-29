import 'package:flutter/material.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';

class ProfileReviewPage extends StatelessWidget {
  const ProfileReviewPage({super.key});

  static const routeName = '/profile-review';

  Widget _buildBulletinText(String text) {
    return Row(
      spacing: 8.0,
      children: <Widget>[
        const SizedBox(width: 4.0),
        const SizedBox.square(
          dimension: 2.5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secText,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13.0,
              color: AppColors.secText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            spacing: 8.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(ImageAssetNames.profileReview),
              const SizedBox(height: 12.0),
              const Text(
                'Your profile is being reviewed!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const Text(
                'We would send you an invite for an on-site '
                'training once your profile review is satisfactory',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secText,
                ),
              ),
              const SizedBox(height: 48.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 18.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: const Color(0xFFFFFCC5),
                ),
                child: Column(
                  spacing: 2.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Only reach out to our customer support team if',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    _buildBulletinText(
                        'You don’t get a main from us after 7 days'),
                    _buildBulletinText(
                        'You need to change any details your used'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
