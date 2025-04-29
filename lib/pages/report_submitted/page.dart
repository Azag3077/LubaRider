import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import 'provider.dart';

class ReportSubmittedPage extends ConsumerWidget {
  const ReportSubmittedPage({super.key});

  static const routeName = '/report-submitted';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(reportSubmittedPageProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12.0,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: CloseButton(
                  onPressed: () => notifier.onReturnToHome(context),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFF2F2F2),
                    foregroundColor: AppColors.primary,
                  ),
                ),
              ),
              Image.asset(ImageAssetNames.doubleCheckmark, height: 124.0)
                  .animate()
                  .scale(curve: Curves.elasticOut, duration: 1000.ms)
                  .fadeIn(duration: 500.ms),
              const Text(
                'Issue Submitted',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(duration: 600.ms).slide(
                    begin: const Offset(0, 0.3),
                    end: const Offset(0, 0),
                    curve: Curves.easeOut,
                    duration: 800.ms,
                  ),
              const Text(
                'Your issue #12456 has been submitted successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secText,
                ),
              ).animate().fadeIn(duration: 600.ms).slide(
                    begin: const Offset(0, 0.3),
                    end: const Offset(0, 0),
                    curve: Curves.easeOut,
                    duration: 800.ms,
                  ),
              const Text(
                'We will review the issue and get '
                'back to you within 15 minutes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secText,
                ),
              ).animate().fadeIn(duration: 600.ms).slide(
                    begin: const Offset(0, 0.3),
                    end: const Offset(0, 0),
                    curve: Curves.easeOut,
                    duration: 800.ms,
                  ),

              const SizedBox(height: 16.0),

              /// The Customer Details
              OutlinedButton(
                onPressed: () => notifier.onViewIssue(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: AppColors.greyOutline,
                  ),
                ),
                child: const Center(child: Text('View Issue Details')),
              ),
              FilledButton(
                onPressed: () => notifier.onReturnToHome(context),
                child: const Center(child: Text('Return to home')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
