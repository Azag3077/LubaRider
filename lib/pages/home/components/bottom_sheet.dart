import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/routers/router.dart';
import '../provider.dart';
import 'home_card.dart';

class MoreServicesSheetContent extends ConsumerWidget {
  const MoreServicesSheetContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(homePageProvider.notifier);

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'More',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CloseButton(
                color: AppColors.primary,
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F3F3),
                ),
                onPressed: () => pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.5,
            ),
            // children: <Widget>[
            //   HomeCard(
            //     onPressed: () => notifier.onExpressDelivery(context),
            //     imageAssetName: ImageAssetNames.truck,
            //     text: 'Express delivery',
            //     bgColor: AppColors.orange50,
            //   ),
            //   HomeCard(
            //     onPressed: () => notifier.onInternationalDelivery(context),
            //     imageAssetName: ImageAssetNames.globeLocation,
            //     text: 'International delivery',
            //     bgColor: const Color(0x1465558F),
            //   ),
            //   HomeCard(
            //     onPressed: () => notifier.onInterstateDelivery(context),
            //     imageAssetName: ImageAssetNames.bike,
            //     text: 'Interstate delivery',
            //     bgColor: AppColors.green50,
            //   ),
            //   HomeCard(
            //     onPressed: () => notifier.onSupport(context),
            //     imageAssetName: ImageAssetNames.support,
            //     text: 'Support',
            //     bgColor: AppColors.containerFg,
            //   ),
            // ],
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
