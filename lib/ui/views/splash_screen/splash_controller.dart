import 'package:auto/core/data/repositories/shared_preference_repository.dart';
import 'package:auto/core/services/base_controller.dart';
import 'package:auto/ui/views/login_screen/login_view.dart';
import 'package:auto/ui/views/wellcom_screen/wellcom_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/repositories/read_all_models.dart';
import '../subscription_screen/subscription_view.dart';

class SplashController extends BaseController {
  @override
  void onInit() {

    Future.delayed(const Duration(seconds: 3)).then((value) async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isSubscribing', true);
      print("SharedPreferenceRepository().getFirstLanuch() ${SharedPreferenceRepository().getFirstLanuch()}");
      if (SharedPreferenceRepository().getFirstLanuch()){
        print("SharedPreferenceRepository().getFirstLanuch() ${SharedPreferenceRepository().getFirstLanuch()}");
        await JsonReader.fetchDataAndStore();
        SharedPreferenceRepository().setFirstLanuch(false);
        Get.to(() => const WelcomeScreen());
      }else{
        print("SharedPreferenceRepository().getFirstLanuch() --/ ${SharedPreferenceRepository().getFirstLanuch()}");
        if (SharedPreferenceRepository().getIsLoggedIn()){
          Get.to(() =>  SubscriptionView());
        }else{
        Get.to(() => const LoginView());}
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
