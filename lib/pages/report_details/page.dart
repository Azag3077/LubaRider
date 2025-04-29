import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/buttons.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/constants.dart';
import '../../core/validators.dart';
import '../../models/issue.dart';
import '../sign_up/components/image_picker.dart';
import 'provider.dart';

class ReportDetailsPage extends ConsumerWidget {
  const ReportDetailsPage(this.deliveryIssue, {super.key});

  final DeliveryIssue deliveryIssue;

  static const routeName = '/report-details';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportDetailsPageProvider);
    final notifier = ref.read(reportDetailsPageProvider.notifier);

    const titleTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
    );

    return Scaffold(
      appBar: AppBar(title: Text(deliveryIssue.title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Tell us your problems', style: titleTextStyle),
            Expanded(
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  ...deliveryIssue.subIssues.map((issue) {
                    return RadioButton(
                      text: issue,
                      height: 0.0,
                      showBorder: false,
                      padding: const EdgeInsets.all(5.0),
                      isSelected: issue == state.choice,
                      onPressed: () => notifier.updateChoice(issue),
                    );
                  }),
                  const SizedBox(height: 16.0),
                  const Text('Add details', style: titleTextStyle),
                  const SizedBox(height: 4.0),
                  TextField(
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(height: 1.2, fontSize: 14.0),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    onChanged: notifier.updateDetails,
                    decoration: InputDecoration(
                      hintText: 'Enter any additional details',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFB0B0B0),
                        fontSize: 12.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kTextFieldRadius),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyOutline),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ImagePickerContainer(
                    height: 130.0,
                    labelText: 'Add photo',
                    labelTextStyle: titleTextStyle,
                    imagePath: state.photo,
                    onSaved: notifier.updatePhoto,
                    validator: Validator.name,
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
            Row(
              spacing: 8.0,
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => notifier.onProceed(context),
                    child: const Row(
                      spacing: 8.0,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Call Support'),
                        Icon(CupertinoIcons.phone),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => notifier.onProceed(context),
                    child: const Row(
                      spacing: 8.0,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Request Repair'),
                        Icon(CupertinoIcons.wrench),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            FilledButton(
              onPressed: state.choice == null
                  ? null
                  : () => notifier.onProceed(context),
              child: const Center(child: Text('Submit')),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
