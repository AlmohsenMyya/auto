import 'package:auto/core/data/repositories/shared_preference_repository.dart';
import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class SubscriptionController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;

  late List<Branch> branchs;

  void readfile() async {
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonData();
    branchs = JsonReader.extractBranches(jsonfile);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = SharedPreferenceRepository().getIsLoggedIn();
    if (isLoggedIn) {
      List<String> myBranchIds =
          await prefs.getStringList('my_branchs_id') ?? [];
      // Filter branches based on the user's branch IDs
      branchs = branchs
          .where((branch) => myBranchIds.contains(branch.branch_id.toString()))
          .toList();
    }

    isLoading.value = false;
  }

  @override
  void onInit() {
    readfile();
    super.onInit();
  }
}
