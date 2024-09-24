import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:auto2/core/data/models/notification_model.dart';
import 'package:auto2/core/utils/extension/context_extensions.dart';
import 'package:auto2/core/utils/extension/widget_extension.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationResponse notification;

  String _formatTime(DateTime dateTime) {
    // Format the time using intl package
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationDetailPage(notification: notification),
          ),
        );
      },
      trailing: const SizedBox.shrink(),
      title: Row(
        children: [
          Container(
            width: 11.sp,
            height: 11.sp,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: context.theme.colorScheme.error,
            ),
          ),
          SizedBox(
            width: .6.sw,
            child: Text(
              notification.title,
              overflow: TextOverflow.ellipsis,
              style: context.exTextTheme.titleLarge!
                  .copyWith(color: context.exOnBackground),
            ).paddingHorizontal(10.w),
          ),
          Text(
            _formatTime(notification.createdAt),
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
            SizedBox(
              width: .75.sw,
              child: Text(
                notification.body,
                maxLines: 3, // Limit to 3 lines
                overflow: TextOverflow.ellipsis,
                style: context.exTextTheme.bodyMedium!
                    .copyWith(color: context.exOnBackground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final NotificationResponse notification;

  const NotificationDetailPage({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الاشعار'),
        backgroundColor: context.exOnPrimaryContainer,
        // backgroundColor: context.theme.colorScheme.primary,
      ),
      backgroundColor: context.exOnPrimaryContainer,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style: context.exTextTheme.headlineMedium!
                  .copyWith(color: context.primaryColor),
            ),
            Divider(),
            SizedBox(height: 16.h),
            Text(
              notification.body,
              style: context.exTextTheme.bodyLarge!
                  .copyWith(color: context.exOnBackground),
            ),

            SizedBox(height: 16.h),
            Text(
              "تم الاستلام في : \n${_formatTime(notification.createdAt)}",
              style: context.exTextTheme.bodySmall!
                  .copyWith(color: context.exOnBackground.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('a hh:mm , dd MMM yyyy').format(dateTime);
  }
}
