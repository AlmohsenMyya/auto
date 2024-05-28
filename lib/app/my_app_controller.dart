

import 'package:auto/core/enums/connectivity_status.dart';
import 'package:auto/core/services/base_controller.dart';
import 'package:auto/core/utils/general_util.dart';

class MyAppController extends BaseController {
  ConnectivityStatus connectionStatus = ConnectivityStatus.onLine;

  @override
  void onInit() async {
    listenToConnectionStatus();
    super.onInit();
  }

  void listenToConnectionStatus() {
    connectivityService.connectivityStatusController.stream.listen((event) {
      connectionStatus = event;
    });
  }
}
