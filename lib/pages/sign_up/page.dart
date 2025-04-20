import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/page_indicator.dart';
import 'page_views/personal_details.dart';
import 'provider.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  static const routeName = '/sign-up';

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _pageController = PageController();
  final _page1FormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(signUpPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: PageIndicator(
            currentIndex: 0,
            length: 4,
          ),
        ),
      ),
      body: Column(
        spacing: 16.0,
        children: <Widget>[
          Expanded(
            child: PageView(
              children: <Widget>[
                PersonalDetailsPageView(
                  formKey: _page1FormKey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FilledButton(
              onPressed: () => notifier.onSignUp(context, _page1FormKey),
              child: const Center(child: Text('Sign up')),
            ),
          ),
        ],
      ),
    );
  }
}
