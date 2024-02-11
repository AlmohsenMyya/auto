import 'package:auto/core/services/base_controller.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
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