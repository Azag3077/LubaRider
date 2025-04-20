import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/extensions/num_duration.dart';
import '../../core/routers/router.dart';
// import '../../models/user_profile.dart';
import '../../network/dio_client.dart';
import '../get_started/page.dart';
// import '../../providers/providers.dart';
// import '../dashboard/page.dart';

final splashScreenProvider =
    Provider.autoDispose<_Provider>((ref) => _Provider(ref));

class _Provider {
  _Provider(this._ref);

  final Ref _ref;

  void initState() => Future.delayed(2.seconds, _navigateToNextScreen);

  Future<void> _navigateToNextScreen() async {
    String routeName = GetStartedPage.routeName;

    if (DioClient.token != null) {
      // routeName = DashboardPage.routeName;
      // final userJson = await DioClient.getUserJson();
      // final userProfile = UserProfile.fromJson(userJson);
      // _ref.read(userProfileStateProvider.notifier).state = userProfile;
    }

    final context = navigatorKey.currentContext;

    if (context == null || !context.mounted) return;

    pushReplacementNamed(context, routeName);
  }
}
