import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../deliveries/page.dart';
import '../home/page.dart';
import 'components/nav_bar_item.dart';
import 'provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  static const routeName = '/dashboard';

  List<Widget> get _screens => const <Widget>[
        HomePage(),
        DeliveriesPage(),
        Scaffold(),
        Scaffold(),
        Scaffold(),
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = ref.watch(dashboardPageProvider);
    final notifier = ref.read(dashboardPageProvider.notifier);

    final screen = _screens[currentPageIndex];

    return PopScope(
      canPop: currentPageIndex == 0,
      onPopInvokedWithResult: (_, __) => notifier.updatePageIndex(0),
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: screen,
        ),
        bottomNavigationBar: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.shade100,
                offset: const Offset(0, -1),
                blurRadius: 2.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            onTap: notifier.updatePageIndex,
            currentIndex: currentPageIndex,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.black400,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
            ),
            unselectedIconTheme: const IconThemeData(color: AppColors.black200),
            unselectedLabelStyle: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
            ),
            items: <BottomNavigationBarItem>[
              CustomBottomNavigationBarItem(
                label: 'Home',
                assetName: ImageAssetNames.home,
                selected: currentPageIndex == 0,
              ),
              CustomBottomNavigationBarItem(
                label: 'Deliveries',
                assetName: ImageAssetNames.deliveries,
                selected: currentPageIndex == 1,
              ),
              CustomBottomNavigationBarItem(
                label: 'Earnings',
                assetName: ImageAssetNames.earnings,
                selected: currentPageIndex == 2,
              ),
              CustomBottomNavigationBarItem(
                label: 'Support',
                assetName: ImageAssetNames.support,
                selected: currentPageIndex == 3,
              ),
              CustomBottomNavigationBarItem(
                label: 'Account',
                assetName: ImageAssetNames.account,
                selected: currentPageIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
