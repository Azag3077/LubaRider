import 'package:flutter/material.dart';

import '../../pages/dashboard/page.dart';
import '../../pages/deliveries/page.dart';
import '../../pages/delivery_complete/page.dart';
import '../../pages/delivery_issues/page.dart';
import '../../pages/delivery_order_details/page.dart';
import '../../pages/forgot_password/page.dart';
import '../../pages/get_started/page.dart';
import '../../pages/notifications/page.dart';
import '../../pages/order_details/page.dart';
import '../../pages/profile_review/page.dart';
import '../../pages/report/page.dart';
import '../../pages/report_details/page.dart';
import '../../pages/report_submitted/page.dart';
import '../../pages/reset_password/page.dart';
import '../../pages/sign_in/page.dart';
import '../../pages/sign_up/page.dart';
import '../../pages/splash_screen/page.dart';
import '../../pages/successful/page.dart';
import '../../pages/verify_otp/page.dart';

export 'router.dart';

T _getArgs<T>(BuildContext context) =>
    ModalRoute.of(context)!.settings.arguments as T;

final appRoutes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),
  '/': (context) => const DashboardPage(),
  GetStartedPage.routeName: (context) => const GetStartedPage(),
  SignInPage.routeName: (context) => SignInPage(),
  SignUpPage.routeName: (context) => const SignUpPage(),
  ProfileReviewPage.routeName: (context) => const ProfileReviewPage(),
  VerifyOtpPage.routeName: (context) => VerifyOtpPage(_getArgs(context)),
  ForgotPasswordPage.routeName: (context) => ForgotPasswordPage(),
  ResetPasswordPage.routeName: (context) => ResetPasswordPage(),
  SuccessfulPage.routeName: (context) => SuccessfulPage(_getArgs(context)),
  DashboardPage.routeName: (context) => const DashboardPage(),
  NotificationsPage.routeName: (context) => const NotificationsPage(),
  OrderDetailsPage.routeName: (context) => OrderDetailsPage(_getArgs(context)),
  DeliveryCompletePage.routeName: (context) =>
      DeliveryCompletePage(_getArgs(context)),
  ReportPage.routeName: (context) => const ReportPage(),
  ReportDetailsPage.routeName: (context) =>
      ReportDetailsPage(_getArgs(context)),
  ReportSubmittedPage.routeName: (context) => const ReportSubmittedPage(),
  DeliveryIssuesPage.routeName: (context) => const DeliveryIssuesPage(),
  DeliveriesPage.routeName: (context) => const DeliveriesPage(),
  DeliveryOrderDetailsPage.routeName: (context) =>
      DeliveryOrderDetailsPage(_getArgs(context)),

  ///
  BlankPage.routeName: (context) => const DashboardPage(),
};

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  static const routeName = '/blank';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Placeholder(
        child: Text('Coming soon'),
      ),
    );
  }
}
