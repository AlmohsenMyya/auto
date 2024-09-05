import 'package:auto/core/data/models/notification_model.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart'; // Import intl package

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationResponse notification;

  String _formatTime(DateTime dateTime) {
    // Use the intl package to format the time (e.g., '12:50 PM')
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        // Handle tap, e.g., open URL or navigate to post comments
      },
      trailing: const SizedBox.shrink(),
      title: Row(
        children: [
          Container(
            width: 11.sp,
            height: 11.sp,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: context.theme.colorScheme.error, // Modify as needed
            ),
          ),
          SizedBox(
            width: .6.sw,
            child: Text(
              notification.title, // No need for null check since it's required
              overflow: TextOverflow.ellipsis,
              style: context.exTextTheme.titleLarge!
                  .copyWith(color: context.exOnBackground),
            ).paddingHorizontal(10.w),
          ),
          Text(
            _formatTime(notification.createdAt), // Display the formatted time
            style: context.exTextTheme.titleSmall!
                .copyWith(color: context.exOnBackground),
          ),
        ],
      ),
      subtitle: IntrinsicHeight(
        child: Row(
          children: [
            VerticalDivider(
              thickness: 1,
              width: 1,
              color: context.theme.colorScheme.error,
            ).paddingHorizontal(5.5.sp),
            5.horizontalSpace,
            SizedBox(width: .75.sw, child: Text(notification.body)),
          ],
        ),
      ),
    );
  }
}
