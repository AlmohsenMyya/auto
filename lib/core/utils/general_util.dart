import 'package:auto2/app/my_app_controller.dart';
import 'package:auto2/core/data/repositories/shared_preference_repository.dart';
import 'package:auto2/core/enums/connectivity_status.dart';
import 'package:auto2/core/enums/message_type.dart';
import 'package:auto2/core/services/connectivity_service.dart';
import 'package:auto2/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';

SharedPreferenceRepository get storage => Get.find<SharedPreferenceRepository>();

//CartService get cartService => Get.find<CartService>();
ConnectivityService get connectivityService => Get.find<ConnectivityService>();
// NotificationService get notificationService => Get.find<NotificationService>();
bool get isOnline => Get.find<MyAppController>().connectionStatus == ConnectivityStatus.onLine;

// void fadeInTransition(Widget view) {
//   Get.to(view, transition: Transition.fadeIn);
// }



