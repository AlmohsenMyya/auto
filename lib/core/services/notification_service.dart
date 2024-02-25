// import 'dart:async';
// import 'dart:developer';
// import 'package:auto/core/data/models/notification_model.dart';
// import 'package:auto/core/enums/application_state.dart';
// import 'package:auto/core/enums/notification_type.dart';
// import 'package:auto/core/utils/general_util.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/utils.dart';
//
// class NotificationService {
//   StreamController<NotificationModel> notificationStream =
//       StreamController.broadcast();
//
//   NotificationService() {
//     onInit();
//   }
//
//   void onInit() async {
//     try {
//       final fcmToken = await FirebaseMessaging.instance.getToken();
//       log(fcmToken.toString());
//
//       //!--- Here to call api ----
//
//       FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
//
//
//         // Note: This callback is fired at each app startup and whenever a new
//         // token is generated.
//         //!--- Here to call api ----
//       }).onError((err) {
//         // Error getting token.
//       });
//
//       if (GetPlatform.isIOS) {
//         FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//         NotificationSettings settings = await messaging.requestPermission(
//           alert: true,
//           provisional: true,
//           sound: true,
//           badge: true,
//           carPlay: false,
//           criticalAlert: false,
//         );
//
//         // if (settings.authorizationStatus == AuthorizationStatus.denied) {
//
//         // }
//       }
//
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         NotificationModel model = NotificationModel.fromJson(message.data);
//         handelNotification(
//             model: model, applicationState: ApplicationState.foreGround);
//       });
//
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         NotificationModel model = NotificationModel.fromJson(message.data);
//         handelNotification(
//             model: model, applicationState: ApplicationState.backGround);
//       });
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   void handelNotification(
//       {required NotificationModel model,
//       required ApplicationState applicationState}) {
//     notificationStream.add(model);
//     if (model.notificatioNType == NotificationType.subsecription.name) {
//       storage.setSubStatus(model.model == '1' ? true : false);
//     }
//   }
// }