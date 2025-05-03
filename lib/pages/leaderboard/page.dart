import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/place_holders.dart';
import '../../components/popup_button.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../core/extensions/num_duration.dart';
import 'provider.dart';

class LeaderboardPage extends ConsumerWidget {
  const LeaderboardPage({super.key});

  static const routeName = '/leaderboard';

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.greyOutline,
      indent: 16.0,
      endIndent: 16.0,
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(leaderboardPageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(18.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(12.0),
              color: AppColors.containerFg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(ImageAssetNames.award1),
                Image.asset(ImageAssetNames.award2),
                Image.asset(ImageAssetNames.award3),
                Image.asset(ImageAssetNames.award4),
                Image.asset(ImageAssetNames.award5),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'You are 8th position',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                FilterPopupButton(),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Rank',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Point',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: AppColors.hintColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          _buildDivider(),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: ListView.separated(
                itemCount: 32,
                separatorBuilder: (context, int index) => _buildDivider(),
                itemBuilder: (context, int index) {
                  final i = index + 1;
                  final n = i < 6 ? i : 'question';
                  final award = 'assets/images/award-$n.png';

                  return ListTile(
                    onTap: () => notifier.onTap(context),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(award),
                        const ImageLoader(
                          '',
                          width: 40.0,
                          height: 40.0,
                          radius: 20.0,
                        ),
                      ],
                    ),
                    title: const Text(
                      r'Gbenga Samson',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                        fontSize: 13.0,
                      ),
                    ),
                    trailing: Text(
                      24450.toPriceWithCurrency(currency: ''),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.hintColor,
                        fontSize: 13.0,
                      ),
                    ),
                    minVerticalPadding: 24.0,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
