import 'package:auto/core/data/models/notification_model.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    Key? key,
    required this.notification,
  }) : super(key: key);
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        // if (notification.url != null) {
        //   launchUrlString(notification.url!, mode: LaunchMode.inAppWebView);
        // } else if (notification.postId != null) {
        //   context.myPushNamed(RoutesNames.comments,
        //       extra: notification.postId!);
        // }
      },
      trailing: const SizedBox.shrink(),
      title: Row(
        children: [
          Container(
            width: 11.sp,
            height: 11.sp,
            decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: notification.isWatched == true
                    ? context.theme.hintColor
                    : context.theme.colorScheme.error),
          ),
          SizedBox(
            width: .6.sw,
            child: Text(
              notification.title!,
              overflow: TextOverflow.ellipsis,

              style: context.exTextTheme.titleLarge!.copyWith(color: context.exOnBackground ),

              ).paddingHorizontal(10.w),
          ),
          Text(
            '12:50م',
            style: context.exTextTheme.titleSmall!.copyWith(color: context.exOnBackground),
          )
        ],
      ),
      subtitle: IntrinsicHeight(
        child: Row(
          children: [
            VerticalDivider(
              thickness: 1,
              width: 1,
              color: notification.isWatched == true
                  ? context.theme.hintColor
                  : context.theme.colorScheme.error,
            ).paddingHorizontal(5.5.sp),
            5.horizontalSpace,
            SizedBox(width: .75.sw, child: Text(notification.body!)),
          ],
        ),
      ),
    );
  }
}
