import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/page_indicator.dart';
import 'page_views/bank_details/view.dart';
import 'page_views/personal_details/view.dart';
import 'page_views/terms_and_condition/view.dart';
import 'page_views/verification_details/view.dart';
import 'page_views/verify_identity/view.dart';
import 'provider.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  static const routeName = '/sign-up';

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _pageController = PageController();
  final _personalDetailsFormKey = GlobalKey<FormState>();
  final _verificationDetailsFormKey = GlobalKey<FormState>();
  final _vehicleBrandFieldKey = GlobalKey<FormFieldState<String>>();

  final _bankDetailsFormKey = GlobalKey<FormState>();
  final _verifyIdentityFormKey = GlobalKey<FormState>();
  final _termsAndConditionsAgreementFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(signUpPageProvider.notifier);
      notifier.initialize(
        pageController: _pageController,
        personalDetailsFormKey: _personalDetailsFormKey,
        verificationDetailsFormKey: _verificationDetailsFormKey,
        bankDetailsFormKey: _bankDetailsFormKey,
        verifyIdentityFormKey: _verifyIdentityFormKey,
        termsAndConditionsAgreementFormKey: _termsAndConditionsAgreementFormKey,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(signUpPageProvider);
    final notifier = ref.read(signUpPageProvider.notifier);

    return PopScope(
      canPop: pageIndex == 0,
      onPopInvokedWithResult: notifier.onPopInvokedWithResult,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PageIndicator(
              length: 5,
              currentIndex: pageIndex,
            ),
          ),
        ),
        body: Column(
          spacing: 8.0,
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: notifier.updatePageIndex,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  PersonalDetailsPageView(
                    formKey: _personalDetailsFormKey,
                  ),
                  VerificationDetailsPageView(
                    formKey: _verificationDetailsFormKey,
                    vehicleBrandFieldKey: _vehicleBrandFieldKey,
                  ),
                  BankDetailsPageView(
                    formKey: _bankDetailsFormKey,
                  ),
                  VerifyIdentityPageView(
                    formKey: _verifyIdentityFormKey,
                  ),
                  TermsAndConditionPageView(
                    formKey: _termsAndConditionsAgreementFormKey,
                  ),
                ],
              ),
            ),
            if (pageIndex != 3)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FilledButton(
                  onPressed: () => notifier.onContinue(context),
                  child: const Center(child: Text('Continue')),
                ),
              ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
