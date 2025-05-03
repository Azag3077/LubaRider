import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../leaderboard/page.dart';
import '../settings/page.dart';

final privacyPolicyPageProvider = Provider((_) => _Provider());

class _Provider {
  void onSettings(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);

  void onLeaderboard(BuildContext context) =>
      pushNamed(context, LeaderboardPage.routeName);
}
