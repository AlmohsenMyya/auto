import 'package:auto/core/data/repositories/shared_preference_repository.dart';
import 'package:auto/core/services/base_controller.dart';
import 'package:auto/ui/views/login_screen/login_view.dart';
import 'package:auto/ui/views/wellcom_screen/wellcom_screen.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  @override
  void onInit() {

    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (!SharedPreferenceRepository().getFirstLanuch()){
        print("SharedPreferenceRepository().getFirstLanuch() ${SharedPreferenceRepository().getFirstLanuch()}");
        SharedPreferenceRepository().setFirstLanuch(true);
        Get.to(() => const WelcomeScreen());
      }else{
        print("SharedPreferenceRepository().getFirstLanuch() --/ ${SharedPreferenceRepository().getFirstLanuch()}");
        Get.to(() => const LoginView());
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
