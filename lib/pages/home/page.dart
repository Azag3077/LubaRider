import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import 'components/tab_bar.dart';
import 'ongoing/page_view.dart';
import 'pending/page_view.dart';
import 'provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _controller = PageController();
  final _pendingTabKey = GlobalKey();
  final _ongoingTabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_controllerListener);

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _controller.jumpToPage(ref.read(homePageProvider).index));
  }

  void _controllerListener() {
    _controller.page;
  }

  @override
  void dispose() {
    _controller.removeListener(_controllerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homePageProvider);
    final notifier = ref.read(homePageProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.containerBg,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Switch(
            value: true,
            onChanged: (_) {},
          ),
        ),
        titleSpacing: 12.0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'John Doe',
              style: TextStyle(
                color: AppColors.containerFg,
                fontWeight: FontWeight.w500,
                fontSize: 19.0,
              ),
            ),
            Text(
              'You are online',
              style: TextStyle(
                color: AppColors.containerFg,
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
              ),
            ),
          ],
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
          preferredSize: const Size.fromHeight(178.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 24.0),
            child: Column(
              spacing: 14.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFEA),
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage(ImageAssetNames.halfBox),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  child: const Text(
                    'Make More\nMoney Everyday',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF272626),
                      fontSize: 19.0,
                    ),
                  ),
                ),
                HomeTabBar(
                  pageValue: state.page,
                  currentIndex: state.index,
                  pendingCount: 0,
                  ongoingCount: 12,
                  pendingTabKey: _pendingTabKey,
                  ongoingTabKey: _ongoingTabKey,
                  onTabSwitch: (index) =>
                      notifier.onTabSwitch(_controller, index),
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: notifier.onPageChanged,
        children: const <Widget>[PendingPageView(), OngoingPageView()],
      ),
    );
  }
}
