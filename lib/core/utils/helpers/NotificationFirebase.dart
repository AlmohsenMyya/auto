import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/read_all_models.dart';

class NotificationSetUp {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // تحقق من اتصال الإنترنت
    if (await _checkInternetConnection()) {
      print('No internet connection.');
      return;
    }

    // تهيئة Firebase
    await _initializeFirebase();

    // إعداد إشعارات FCM
    await _setupFCM();
  }

  // التحقق من اتصال الإنترنت
  static Future<bool> _checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    print(
        "njjnckkdsnkj ${connectivityResult.contains(ConnectivityResult.none)} ${connectivityResult != ConnectivityResult.none}");
    return connectivityResult.contains(ConnectivityResult.none);
  }

  // تهيئة Firebase
  static Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp().timeout(Duration(seconds: 5));
    } on FirebaseException catch (e) {
      print('Firebase initialization failed: $e');
    } catch (e) {
      print('An unexpected error occurred during Firebase initialization: $e');
    }
  }

  // إعداد FCM وتخزين الـ FCM Token
  static Future<void> _setupFCM() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      // الحصول على FCM Token
      String? fcmToken =
          await messaging.getToken().timeout(Duration(seconds: 5));
      print('FCM Token: $fcmToken');
      await _storeFCMToken(fcmToken);

      // إعدادات الإشعارات الخاصة بـ iOS
      if (Platform.isIOS) {
        await messaging.requestPermission(
          badge: true,
          alert: true,
          sound: true,
          announcement: true,
        );
      }

      // طلب صلاحيات الإشعارات
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      // الاشتراك في الموضوع
      await messaging.subscribeToTopic("newnoti");

      // إعداد الإشعارات الخلفية
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // إعداد الإشعارات المحلية
      await _setUpNotifications();

      // التعامل مع الإشعارات عند ورودها
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print(
            "Almohsen FirebaseMessaging.onMessage.listen((RemoteMessage message)");
        await JsonReader.fetchDataAndStore();
        _showNotification(message);
      });

      // التعامل مع الإشعارات عند فتح التطبيق
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        print("Almohsen FirebaseMessaging.onMessageOpenedApp.listen");
        _handleMessage(message);
      });
    } catch (e) {
      print('Error setting up FCM: $e');
    }
  }

  // تخزين FCM Token في SharedPreferences
  static Future<void> _storeFCMToken(String? fcmToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcmToken', fcmToken ?? "null problem");
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

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (payload != null) {
        print("Notification payload: $payload");
        // يمكنك هنا تنفيذ منطق إضافي بناءً على البيانات في الـ payload
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
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
                icon: android.smallIcon, // تحديد ملف الصوت بدون الامتداد
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
                // تحديد ملف الصوت مع الامتداد الصحيح
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
