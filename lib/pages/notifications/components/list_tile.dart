import 'package:flutter/cupertino.dart' hide Notification;
import 'package:flutter/material.dart' hide Notification;

import '../../../core/constants/colors.dart';
import '../../../core/extensions/datetime.dart';
import '../../../models/notification.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    super.key,
    required this.onTap,
    required this.notification,
  });

  final VoidCallback onTap;
  final Notification notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(notification.id),
      onTap: onTap,
      title: Row(
        spacing: 8.0,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.containerFg,
            ),
            child: const Icon(
              size: 18.0,
              CupertinoIcons.bell,
              color: Color(0xFF6D6D6D),
            ),
          ),
          Expanded(
            child: Text(
              notification.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
                fontSize: 13.0,
              ),
            ),
          ),
          Text(
            notification.datetime.toTimeStr,
            style: const TextStyle(
              color: AppColors.hintColor,
              fontWeight: FontWeight.w500,
              fontSize: 11.0,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          notification.subtitle,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.black400,
            fontSize: 11.0,
          ),
        ),
      ),
    );
  }
}
