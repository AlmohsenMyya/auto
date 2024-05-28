import 'package:auto/core/data/models/notification_model.dart';
import 'package:auto/core/utils/extension/widget_extension.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/notification_screen/widgets/NotificationListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationModel> indexNotificationModel = [
    NotificationModel(
        url: '', type: 1, body: 'المدير  طلب رؤيتك', title: 'طلب حضور'),
    NotificationModel(
        url: '',
        type: 1,
        body: 'مدير  عقد اجتماع الساعة الثانية',
        title: ' طلب حضور')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          onTap: () => Navigator.of(context).pop(), titleText: 'الإشعارات'),
      body: ListView.builder(
        itemCount: indexNotificationModel.length,
        itemBuilder: (context, index) => NotificationListTile(
          notification: indexNotificationModel[index],
        ),
      ).paddingAll(14.w),
    );
  }
}
