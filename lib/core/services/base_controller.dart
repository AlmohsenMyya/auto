import 'package:auto2/core/enums/request_status.dart';

import 'package:get/get.dart';

class BaseController extends GetxController {
 
  Rx<RequestStatus> requestStatus = RequestStatus.defaulT.obs;


}