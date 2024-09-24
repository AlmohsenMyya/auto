import 'package:auto2/core/data/repositories/shared_preference_repository.dart';
import 'package:auto2/core/services/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class SubscriptionController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;

  RxBool isUpdateLoading = false.obs;

  late List<Branch> branchs;

  void updateData(bool? isVistore) async {
    // Display the Snackbar and get the SnackbarController
    SnackbarController snackbarController = Get.showSnackbar(
      GetSnackBar(
        borderColor: Colors.blue,
        title: "تنبيه",
        message: "جاري تحميل البيانات هذه العملية قد تأخذ وقتاً ",
        backgroundColor: Colors.blueGrey,
        isDismissible: false,
        // Make the Snackbar non-dismissible by the user
        duration: Duration(days: 1), // Set a long duration to keep it visible
      ),
    );

    isUpdateLoading.value = true;
    isLoading.value = true;
    update();
    await JsonReader.fetchDataAndStore();
   await readfile(isVistore);
    isUpdateLoading.value = false;
    isLoading.value = false;

    // Once the fetching is complete, dismiss the Snackbar
    snackbarController.close();
    update();
  }

  Future<void> readfile(bool? isVistor) async {
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
