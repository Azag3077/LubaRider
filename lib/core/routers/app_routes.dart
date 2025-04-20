import 'package:flutter/material.dart';

import '../../pages/dashboard/page.dart';
import '../../pages/forgot_password/page.dart';
import '../../pages/get_started/page.dart';
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
  GetStartedPage.routeName: (context) => const GetStartedPage(),
  SignInPage.routeName: (context) => SignInPage(),
  SignUpPage.routeName: (context) => const SignUpPage(),
  VerifyOtpPage.routeName: (context) => VerifyOtpPage(_getArgs(context)),
  ForgotPasswordPage.routeName: (context) => ForgotPasswordPage(),
  ResetPasswordPage.routeName: (context) => ResetPasswordPage(),
  SuccessfulPage.routeName: (context) => SuccessfulPage(_getArgs(context)),
  DashboardPage.routeName: (context) => const DashboardPage(),
};
