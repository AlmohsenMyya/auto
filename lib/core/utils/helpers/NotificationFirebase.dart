import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSetUp {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static init() async {
    await Firebase.initializeApp();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcmToken = await messaging.getToken();
    print('FCM Token: $fcmToken');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcmToken', fcmToken ?? "null problem");

    if (Platform.isIOS) {
      messaging.requestPermission(
          badge: true, alert: true, sound: true, announcement: true);
    }

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    messaging.subscribeToTopic("newnoti");
    await _setUpNotifications();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message);
    });
  }

  static _setUpNotifications() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'newnoti', // id
      'High Importance Notifications', // title
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");

    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
          final String? payload = notificationResponse.payload;
          if (payload != null) {
            print("Notification payload: $payload");
            // يمكنك هنا تنفيذ منطق إضافي بناءً على البيانات في الـ payload
          }
        });
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    _showNotification(message);
    print("Handling a background message: ${message.messageId}");
  }

  static void _showNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;

    if (notification != null) {
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                "newnote",
                "High Importance Notifications",
                icon: android.smallIcon,
                sound: RawResourceAndroidNotificationSound('custom_sound.mp3'), // تحديد ملف الصوت بدون الامتداد
              ),
            ));
      } else if (apple != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                subtitle: notification.title,
                badgeNumber: 1,
                presentSound: true,
                sound: 'custom_sound.aiff', // تحديد ملف الصوت مع الامتداد الصحيح
                presentBanner: true,
                presentList: true,
                presentBadge: true,
              ),
            ));
      }
    }
  }

  static void _handleMessage(RemoteMessage message) {
    // قم بمعالجة الرسالة هنا عندما يتم فتح التطبيق من الإشعار
    print("Message data: ${message.data}");
    if (message.notification != null) {
      print("Message also contained a notification: ${message.notification}");
    }
  }
}
