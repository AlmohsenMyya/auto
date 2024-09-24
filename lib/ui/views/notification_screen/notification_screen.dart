import 'package:auto2/ui/views/notification_screen/service/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:auto2/ui/shared/main_app_bar.dart';
import 'package:auto2/core/utils/extension/context_extensions.dart';
import 'package:auto2/core/utils/extension/widget_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto2/ui/views/notification_screen/widgets/NotificationListTile.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/data/models/notification_model.dart';
import '../../../core/services/notification_service.dart';
import 'notification_shimmer.dart'; // Add the shimmer package in pubspec.yaml

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationResponse>> notificationsFuture;

  @override
  void initState() {
    super.initState();
    notificationsFuture = NotificationMohsenService.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.exOnPrimaryContainer,
      appBar: MainAppBar(
        backGroundColor: context.exOnPrimaryContainer,
        onTap: () => Navigator.of(context).pop(),
        titleText: 'الإشعارات',
      ),
      body: FutureBuilder<List<NotificationResponse>>(
        future: notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show the improved shimmer while loading
            return ListView.builder(
              itemCount: 6, // Number of shimmer tiles to show while loading
              itemBuilder: (context, index) {
                return const NotificationShimmer(); // Use redesigned shimmer
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications available'));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) => NotificationListTile(
              notification: notifications[index],
            ),
          ).paddingAll(14.w);
        },
      ),
    );
  }}