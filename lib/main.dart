import 'package:auto/app/my_app.dart';
import 'package:auto/app/my_app_controller.dart';
import 'package:auto/core/data/models/local_json/all_models.dart';
import 'package:auto/core/data/repositories/read_all_models.dart';
import 'package:auto/core/data/repositories/shared_preference_repository.dart';
import 'package:auto/core/services/connectivity_service.dart';
import 'package:auto/core/utils/helpers/NotificationFirebase.dart';
import 'package:auto/ui/views/wellcom_screen/questions_shared.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/notification_service.dart';
import 'firebase_options.dart';
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Uri? deepLink;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDeepLink();
  await NotificationSetUp.init();
  await Get.putAsync(
    () async {
      var sharedPref = await SharedPreferences.getInstance();
      return sharedPref;
    },
  );

  Get.put(SharedPreferenceRepository());
  Get.put(ConnectivityService());
  Get.put(MyAppController());

  Get.put(NotificationService());

  runApp(const MyApp());
}
Future<void> initDeepLink() async {
  print(" dfvdfv start no thisn sdjkn jcn  s");
  print("dfvdfv initialLink out1  $deepLink");
  // Check if you received the link via `getInitialLink` first
  final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

  if (initialLink != null) {
    deepLink = initialLink.link;
    print("dfvdfv initialLink != null deeeplinkk is  $deepLink");
    await _handleDeepLink(deepLink!);
    // Example of using the dynamic link to push the user to a different screen
    // Navigator.pushNamed(context, deepLink.path);
  }

  FirebaseDynamicLinks.instance.onLink.listen(
        (pendingDynamicLinkData) async {
      // Set up the `onLink` event listener next as it may be received here
      deepLink = pendingDynamicLinkData.link;
      print("dfvdfv eDynamicLinks.instance.onLink.listen deeeplinkk is  $deepLink");
      await _handleDeepLink(deepLink!);
      // Example of using the dynamic link to push the user to a different screen
      // Navigator.pushNamed(context, deepLink.path);
    },
  ).onError((error) {
    print("dfvdfv 888 error $error");
    // Handle errors
  });

  print("dfvdfv initialLink out2  $deepLink");
}
Future<void> _handleDeepLink(Uri deepLink) async {
  final Uri uri = deepLink;
  print("--dfvdfv --- $uri");

  // Extract the id from the query parameters
  final String? id = uri.queryParameters['myQuestion'];

  if (id != null) {
    // Navigate to the story page with the extracted id
    print("your ud dfvdfv $id");
    // Navigate to the video screen
    var jsonfile = await JsonReader.loadJsonData();
    Question? question = await JsonReader.extractOneQuestionById(id ,jsonfile)  ;
    print("66655jjj $question");
    if (question != null ){
      print("question != null");
      Get.to(SingleQuestionPage(question: question));

    }
  } else {
    print("dfvdfv ID not found in the deep link");
  }
}
Future <void> init_notifcations ()async {
  final FlutterLocalNotificationsPlugin localNot =
  FlutterLocalNotificationsPlugin();
  final NotificationAppLaunchDetails? noti =
  await localNot.getNotificationAppLaunchDetails();
  print(" pppppgghjj ${noti?.notificationResponse?.payload}");
}