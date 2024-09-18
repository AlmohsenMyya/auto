import 'package:auto/core/data/repositories/shared_preference_repository.dart';
import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class SubscriptionController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;

  RxBool isUpdateLoading = false.obs;

  late List<Branch> branchs;

  void updateData() async {
    isUpdateLoading.value = true;
    isLoading.value = true;
    update();
    await JsonReader.fetchDataAndStore();

    isUpdateLoading.value = false;
    isLoading.value = false;
    update();
  }

  void readfile(bool? isVistor) async {
    isLoading.value = true;
    // قراءة ملف الـ JSON
    jsonfile = await JsonReader.loadJsonData();
    branchs = JsonReader.extractBranches(jsonfile);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = SharedPreferenceRepository().getIsLoggedIn();

    if (isLoggedIn) {
      List<String> myBranchIds =
          await prefs.getStringList('my_branchs_id') ?? [];

      // تعيين isVistor إلى true فقط للفروع التي ID خاصتها موجودة في myBranchIds
      branchs.forEach((branch) {
        if (myBranchIds.contains(branch.branchId.toString())) {
          branch.isVistor = true;
        }
      });
      // if (isVistor == true) {
      //   branchs = branchs
      //       .where((branch) => myBranchIds.contains(branch.branchId.toString()))
      //       .toList();
      // }
      // يمكنك أيضًا تصفية الفروع حسب isVistor إذا كنت تريد عرض الأفرع التي اشتركت بها فقط
      if (isVistor != true) {
        branchs = branchs.where((branch) => branch.isVistor).toList();
      }
    }

    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
