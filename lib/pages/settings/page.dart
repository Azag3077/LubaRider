import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/colors.dart';
import 'provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  Widget _buildListTile({
    required String text,
    Widget? leading,
    Color? textColor,
    bool showTrailingArrow = true,
    required VoidCallback onTap,
  }) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          leading: leading,
          title: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: textColor ?? AppColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          horizontalTitleGap: 8.0,
          trailing: showTrailingArrow
              ? const Icon(
                  Icons.arrow_forward,
                  size: 18.0,
                  color: AppColors.text,
                )
              : null,
        ),
        const Divider(
          color: AppColors.greyOutline,
          indent: 16.0,
          endIndent: 16.0,
          height: 0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(settingsPageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: <Widget>[
          _buildListTile(
            text: 'Rider’s Handbook',
            onTap: () => notifier.onRiderHandbook(context),
          ),
          _buildListTile(
            text: 'Reset PIN',
            onTap: () => notifier.onResetPIN(context),
          ),
          _buildListTile(
            text: 'Privacy policy',
            onTap: () => notifier.onPrivacyPolicy(context),
          ),
          _buildListTile(
            text: 'Terms & Conditions',
            onTap: () => notifier.onTermsConditions(context),
          ),
          _buildListTile(
            text: 'Log Out',
            leading: const Icon(
              Icons.logout,
              size: 18.0,
            ),
            onTap: () => notifier.onLogout(context),
          ),
          _buildListTile(
            text: 'Delete account',
            textColor: Colors.red,
            leading: const Icon(
              color: AppColors.red500,
              CupertinoIcons.trash,
              size: 18.0,
            ),
            onTap: () => notifier.onDeleteAccount(context),
          ),
        ],
      ),
    );
  }
}
