import 'package:auto/core/enums/request_status.dart';
import 'package:auto/core/utils/general_util.dart';
import 'package:auto/ui/shared/utils.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:get/get.dart';

class BaseController extends GetxController {
 
  Rx<RequestStatus> requestStatus = RequestStatus.defaulT.obs;


  Future runFutureFunction({required Future function}) async {
    checkConnection(() async {
      await function;
    });
  }

  Future runLoadingFutureFunction(
      {required Future function,
     }) async {
    return checkConnection(() async {
      requestStatus.value = RequestStatus.loading;
     
      await function;
      requestStatus.value = RequestStatus.defaulT;
    
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