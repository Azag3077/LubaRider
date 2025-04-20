import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/colors.dart';
import 'core/constants/constants.dart';
import 'core/routers/app_routes.dart';
import 'network/dio_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioClient().initializeClient();

  runApp(const ProviderScope(child: LubaDriver()));
}

class LubaDriver extends StatelessWidget {
  const LubaDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luba',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat',
        fontFamilyFallback: const <String>['Roboto'],
        dividerColor: AppColors.greyOutline,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF050505),
            fontSize: 19.0,
          ),
        ),
        textTheme: const TextTheme(
          // titleLarge: TextStyle(
          //   fontSize: 22,
          //   height: 32 / 22,
          //   color: AppColors.text,
          //   fontWeight: FontWeight.bold,
          // ),
          // bodyMedium: TextStyle(color: AppColors.text),
          // bodyLarge: TextStyle(color: AppColors.text),
          labelMedium: TextStyle(
            height: 1.4,
            fontSize: 13.0,
            color: AppColors.secText,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.text,
            fontSize: 19.0,
            height: 1.4,
          ),
          headlineMedium: TextStyle(
            height: 1.4,
            fontSize: 28.0,
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            textStyle: const TextStyle(
              height: 1.4,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kButtonRadius),
            ),
          ),
        ),
        // outlinedButtonTheme: OutlinedButtonThemeData(
        //   style: OutlinedButton.styleFrom(
        //     foregroundColor: AppColors.primary,
        //     textStyle: TextStyle(
        //       fontSize: 16.0.sp,
        //       height: 32 / 22,
        //       fontFamily: 'Poppins',
        //       fontWeight: FontWeight.w800,
        //     ),
        //     padding: EdgeInsets.symmetric(
        //       horizontal: 18.0.w,
        //       vertical: 14.0.h,
        //     ),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(kButtonRadius),
        //     ),
        //     side: const BorderSide(color: AppColors.primary),
        //   ),
        // ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              color: AppColors.primary,
              fontSize: 14.0,
            ),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          showDragHandle: true,
          backgroundColor: Colors.white,
          dragHandleColor: Theme.of(context).highlightColor,
        ),
      ),
      routes: appRoutes,
      navigatorKey: navigatorKey,
    );
  }
}
