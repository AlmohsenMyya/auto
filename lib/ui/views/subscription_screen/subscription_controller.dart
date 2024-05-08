import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class SubscriptionController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;

  late List<Branch> branchs;

  void readfile() async {
    isLoading.value = true ;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonFromAssets('assets/data.json');
    branchs = JsonReader.extractBranches(jsonfile);
    isLoading.value = false;
  }

  @override
  void onInit() {
    readfile();
    super.onInit();
  }
}
