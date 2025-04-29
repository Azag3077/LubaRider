import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/buttons.dart';
import '../../core/constants/constants.dart';
import '../../models/issue.dart';
import 'provider.dart';

class ReportPage extends ConsumerWidget {
  const ReportPage({super.key});

  static const routeName = '/report';

  List<DeliveryIssue> get _deliveryIssues =>
      deliveryIssues.map((json) => DeliveryIssue.fromJson(json)).toList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choice = ref.watch(reportPageProvider);
    final notifier = ref.read(reportPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Select category')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Please select the category that best describe the issue',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  ..._deliveryIssues.map((deliveryIssue) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: RadioButton(
                        text: deliveryIssue.title,
                        isSelected: deliveryIssue.title == choice?.title,
                        onPressed: () => notifier.updateState(deliveryIssue),
                      ),
                    );
                  }),
                ],
              ),
            ),
            FilledButton(
              onPressed:
                  choice == null ? null : () => notifier.onProceed(context),
              child: const Center(child: Text('Proceed')),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
