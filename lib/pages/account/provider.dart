import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../boost_earnings/page.dart';
import '../leaderboard/page.dart';
import '../settings/page.dart';

final accountPageProvider = Provider((_) => _Provider());

class _Provider {
  void onSettings(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);

  void onLeaderboard(BuildContext context) =>
      pushNamed(context, LeaderboardPage.routeName);

  void onBoostEarnings(BuildContext context) =>
      pushNamed(context, BoostEarningsPage.routeName);
}
