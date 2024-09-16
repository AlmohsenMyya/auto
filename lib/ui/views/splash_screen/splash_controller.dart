import 'dart:convert';

import 'package:auto/core/data/repositories/shared_preference_repository.dart';
import 'package:http/http.dart' as http;
import 'package:auto/core/services/base_controller.dart';
import 'package:auto/ui/views/login_screen/login_view.dart';
import 'package:auto/ui/views/wellcom_screen/wellcom_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/repositories/read_all_models.dart';
import '../subscription_screen/subscription_view.dart';

class SplashController extends BaseController {
  Future<bool> checkUserActivationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String codeId = prefs.getString("code_id") ?? "000";
    try {
      // تحقق من الاتصال بالإنترنت
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        // إذا لم يكن هناك اتصال بالإنترنت، نرد بـ true
        return true;
      }

      // إذا كان هناك اتصال بالإنترنت، نتحقق من حالة المستخدم عبر API
      final response = await http
          .get(Uri.parse('https://auto-sy.com/api/is-active?code_id=$codeId'));
      print(
          "checkUserActivationStatus ${response.statusCode} ${response.body}");
      if (response.statusCode == 200) {
        // تحليل الاستجابة
        var data = json.decode(response.body);
        if (data['is_active'] == 0) {
          // إذا كان المستخدم غير مفعل، نرد بـ false
          return false;
        } else {
          // إذا كان المستخدم مفعل، نرد بـ true
          return true;
        }
      } else {
        // في حال فشل الاتصال بالسيرفر لأي سبب آخر، نرد بـ true
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
      bool isCodeActive = await checkUserActivationStatus();
      print("checkUserActivationStatus $isCodeActive");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!isCodeActive) {
        await prefs.clear();
      }
      prefs.setBool('isSubscribing', true);
      print(
          "SharedPreferenceRepository().getFirstLanuch() ${SharedPreferenceRepository()
              .getFirstLanuch()}");
      if (SharedPreferenceRepository().getFirstLanuch()) {
        print(
            "SharedPreferenceRepository().getFirstLanuch() ${SharedPreferenceRepository()
                .getFirstLanuch()}");
        try {
          await JsonReader.fetchDataAndStore();
        } catch (e) {}
        SharedPreferenceRepository().setFirstLanuch(false);
        Get.to(() => const WelcomeScreen());
      } else {
        print(
            "SharedPreferenceRepository().getFirstLanuch() --/ ${SharedPreferenceRepository()
                .getFirstLanuch()}");
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
