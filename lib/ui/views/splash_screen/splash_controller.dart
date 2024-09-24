import 'dart:convert';

import 'package:auto2/core/data/repositories/shared_preference_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:auto2/core/services/base_controller.dart';
import 'package:auto2/ui/views/login_screen/login_view.dart';
import 'package:auto2/ui/views/wellcom_screen/wellcom_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/repositories/read_all_models.dart';
import '../subscription_screen/subscription_view.dart';

class SplashController extends BaseController {
  Future<bool> checkUserActivationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String codeId = prefs.getString("code_id") ?? "000";
    String? jsonFilePath = prefs.getString('jsonFilePath');
    try {
      // تحقق من الاتصال بالإنترنت
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        print("checkUserActivationStatus noInternet");
        // إذا لم يكن هناك اتصال بالإنترنت، نرد بـ true
        return true;
      }

      // إذا كان هناك اتصال بالإنترنت، نتحقق من حالة المستخدم عبر API
      final response = await http
          .get(Uri.parse('https://auto-sy.com/api/is-active?code_id=$codeId'));
      if (response.statusCode == 200) {
        // تحليل الاستجابة
        var data = json.decode(response.body);
        print("checkUserActivationStatus ${data['is_active']}");
        if (data['is_active'] == 0) {
          ;

          await prefs.clear();
          if (jsonFilePath != null) {
            await prefs.setString("jsonFilePath", jsonFilePath);
          }

          // إذا كان المستخدم غير مفعل، نرد بـ false
          return false;
        } else {
          // إذا كان المستخدم مفعل، نرد بـ true
          return true;
        }
      } else {
        // في حال فشل الاتصال بالسيرفر لأي سبب آخر، نرد بـ true
        print(
            "checkUserActivationStatus error with server ${response.statusCode} ${response.body}");
        return true;
      }
    } catch (e) {
      print("checkUserActivationStatus $e");
      // في حال حدوث أي خطأ (مثل عدم وجود إنترنت)، نرد بـ true
      return true;
    }
  }

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      print("srfece sscsdvn ");
      checkUserActivationStatus();
      print("end sscsdvn ");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonFilePath = prefs.getString('jsonFilePath');

      prefs.setBool('isSubscribing', true);
      print(
          "SharedPreferenceRepository().getFirstLanuch() ${SharedPreferenceRepository().getFirstLanuch()}");
      if (SharedPreferenceRepository().getFirstLanuch()) {
        print(
            "SharedPreferenceRepository().getFirstLanuch() ${SharedPreferenceRepository().getFirstLanuch()}");
        try {
          if (jsonFilePath == null) {
            // Display the Snackbar and get the SnackbarController
            SnackbarController snackbarController = Get.showSnackbar(
              GetSnackBar(
                borderColor: Colors.blue,
                title: "تنبيه",
                message:
                    "جاري تحميل البيانات هذه العملية قد تأخذ وقتاً في المرة الأولى",
                backgroundColor: Colors.blueGrey,
                isDismissible: false,
                // Make the Snackbar non-dismissible by the user
                duration:
                    Duration(days: 1), // Set a long duration to keep it visible
              ),
            );

            // Fetch data
            await JsonReader.fetchDataAndStore();

            // Once the fetching is complete, dismiss the Snackbar
            snackbarController.close(withAnimations: true);
          }
        } catch (e) {}
        SharedPreferenceRepository().setFirstLanuch(false);
        Get.to(() => const WelcomeScreen());
      } else {
        print(
            "SharedPreferenceRepository().getFirstLanuch() --/ ${SharedPreferenceRepository().getFirstLanuch()}");
        if (SharedPreferenceRepository().getIsLoggedIn()) {
          Get.to(() => SubscriptionView());
        } else {
          Get.to(() => const LoginView());
        }
      }
    });
    // if (storage.getOrderPlaced()) {
    //   cartService.clearCart();
    //   storage.setOrderPlaced(false);
    // }
    // Future.delayed(Duration(seconds: 5)).then((value) {
    //   if (storage.getFirstLanuch()) {
    //     Get.off(() => IntroView());
    //   } else {
    //     storage.getTokenInfo() != null
    //         ? Get.off(() => MainView())
    //         : Get.off(() => MainView());
    //   }
    //   storage.setFirstLanuch(false);
    //   // Get.back()
    //   //Get.to(page)
    // });

    super.onInit();
  }
}
