import 'package:auto/core/enums/operation_type.dart';
import 'package:auto/core/enums/request_status.dart';
import 'package:auto/core/utils/general_util.dart';
import 'package:auto/ui/shared/utils.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:get/get.dart';

class BaseController extends GetxController {
  // FOR RAM (dependency injection)
  //UserRepository userRepository = Get.put(UserRepository());
  //
  Rx<RequestStatus> requestStatus = RequestStatus.defaulT.obs;
  RxList<OperationType> listType = <OperationType>[].obs;

  Future runFutureFunction({required Future function}) async {
    checkConnection(() async {
      await function;
    });
  }

  Future runLoadingFutureFunction(
      {required Future function,
      OperationType? type = OperationType.none}) async {
    return checkConnection(() async {
      requestStatus.value = RequestStatus.loading;
      listType.add(type!);
      await function;
      requestStatus.value = RequestStatus.defaulT;
      listType.remove(type);
    });
  }

  Future runFullLoadingFutureFunction({
    required Future function,
  }) async {
    checkConnection(() async {
      customLoader();
      await function;
      BotToast.closeAllLoading();
    });
  }
}