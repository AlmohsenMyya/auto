import 'package:auto/app/my_app_controller.dart';
import 'package:auto/core/data/repositories/shared_preference_repository.dart';
import 'package:auto/core/services/connectivity_service.dart';
import 'package:auto/core/services/location_service.dart';
import 'package:auto/core/services/notification_service.dart';
import 'package:auto/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(
    () async {
      var sharedPref = await SharedPreferences.getInstance();
      return sharedPref;
    },
  );

  Get.put(SharedPreferenceRepository());
  //Get.put(CartService());
  Get.put(LocationService());
  Get.put(ConnectivityService());
  Get.put(MyAppController());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(NotificationService());

  runApp(const MyApp());
}