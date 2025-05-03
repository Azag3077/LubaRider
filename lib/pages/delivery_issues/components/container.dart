import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class DeliveryIssuesContainer extends StatelessWidget {
  const DeliveryIssuesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: DefaultTextStyle(
        style: DefaultTextStyle.of(context).style.copyWith(
              fontSize: 13.0,
              color: AppColors.text,
              fontWeight: FontWeight.w500,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 3.0,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.green50,
                  ),
                  child: const Text(
                    'Resolved',
                    style: TextStyle(color: AppColors.green600),
                  ),
                ),
                const Text(
                  'Wednesday 12th February 2025',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: AppColors.hintColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Order #12345678'),
                Text(
                  'View orders',
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Issues Categories',
              style: TextStyle(
                fontSize: 11.0,
                color: AppColors.hintColor,
              ),
            ),
            const SizedBox(height: 4.0),
            const Text('I can’t reach the customer'),
            const SizedBox(height: 16.0),
            const Text(
              'Latest Message',
              style: TextStyle(
                fontSize: 11.0,
                color: AppColors.hintColor,
              ),
            ),
            const SizedBox(height: 4.0),
            const Text(
              'Please be sure you have uploaded your call '
              'log and kindly try to reach the customer '
              'via whatsapp Calls or SMS (text).',
              style: TextStyle(
                fontSize: 13.0,
                color: AppColors.text,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24.0),
            OutlinedButton(
              onPressed: () {},
              child: const Center(child: Text('View Chat')),
            ),
          ],
        ),
      ),
    );
  }
}
