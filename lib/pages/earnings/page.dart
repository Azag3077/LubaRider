import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/place_holders.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../home/pending/provider.dart';
import 'components/list_tile.dart';
import 'provider.dart';

class EarningsPage extends ConsumerWidget {
  const EarningsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(earningsPageFutureProvider);
    final notifier = ref.read(earningsPageProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.containerBg,
        title: const Text(
          'Earnings',
          style: TextStyle(
            color: AppColors.containerFg,
            fontWeight: FontWeight.w500,
            fontSize: 19.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => notifier.onBellIcon(context),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.green50,
              foregroundColor: AppColors.primary,
            ),
            icon: const Icon(CupertinoIcons.bell),
          ),
          const SizedBox(width: 16.0),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(200.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 24.0),
            child: Column(
              spacing: 14.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E2D06),
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage(ImageAssetNames.homeCardEllipse),
                      alignment: Alignment.topRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Available Balance',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9FAB9B),
                          fontSize: 14.0,
                        ),
                      ),
                      const Row(
                        spacing: 2.0,
                        children: <Widget>[
                          Text(
                            '0',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 32.0,
                            ),
                          ),
                          Text(
                            'NGN',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF6E816A),
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      FilledButton(
                        onPressed: () => notifier.onWithdraw(context),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                        ),
                        child: const Center(child: Text('Withdraw Money')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: 14.0),
              const Text(
                'Recent Transactions',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('View all',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                      fontSize: 13.0,
                    )),
              ),
            ],
          ),
          const Divider(
            color: AppColors.greyOutline,
            height: 0,
          ),
          Expanded(
            child: asyncValue.when(
              error: (error, stackTrace) {
                return Column(
                  spacing: 8.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('An error as occurred'),
                    FilledButton(
                      style: FilledButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () => ref.refresh(pendingOrderFutureProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                );
              },
              loading: () {
                return const Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: CustomLoadingWidget(showBottom: false),
                );
              },
              data: (earnings) {
                if (earnings.isEmpty) {
                  return Center(
                    child: Column(
                      spacing: 12.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(ImageAssetNames.blankList)
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .scale(duration: 600.ms, curve: Curves.easeOutBack),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 56.0),
                          child: Text(
                            'Nothing to show yet. '
                            'Click account to set up your profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        )
                            .animate()
                            .slideY(begin: 0.3, duration: 500.ms)
                            .fadeIn(duration: 500.ms),
                        const SizedBox(height: 80.0),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: earnings.length,
                  itemBuilder: (context, int index) {
                    final earning = earnings.elementAt(index);

                    return EarningListTile(
                      earning: earning,
                      onTap: () => notifier.onViewEarning(context, earning),
                    );
                  },
                )
                    .animate()
                    .fadeIn(duration: 400.ms)
                    .slideY(begin: 0.1, duration: 400.ms);
              },
            ),
          ),
        ],
      ),
    );
  }
}
