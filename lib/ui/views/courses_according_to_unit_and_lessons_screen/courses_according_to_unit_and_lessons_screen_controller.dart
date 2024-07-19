import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class CoursesAccordingToUnitAndLessonsScreenController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;
 late List<Part> parts;
  var filteredparts = <Part>[].obs;
  void readfile(int subject_id) async {
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonData();
    parts = JsonReader.extractParts(jsonfile, subject_id);
    filteredparts.value = parts;
    print("object ddddddddd ${parts.length}");

    isLoading.value = false;
  }


  void filterparts(String query) {
    if (query.isEmpty) {
      filteredparts.value = parts;
    } else {
      isLoading.value = true;
      filteredparts.value = parts.where((bank) => bank.name.contains(query)).toList();
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
  }
}
