import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class LessonScreenController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;
  RxList<Unit> units = <Unit>[].obs;
  RxList<Lesson> lessons = <Lesson>[].obs;
  var filteredlessons = <Lesson>[].obs;
  void readLesson(int unitId) async {
    isLoading.value = true;
    jsonfile = await JsonReader.loadJsonData();
    lessons.assignAll(JsonReader.extractLessonByUnitId(jsonfile, unitId));
    filteredlessons.value = lessons;
    print("object ddddddddd ${lessons.length} for unit $unitId");
    isLoading.value = false;
  }

  void filterlessons(String query) {
    if (query.isEmpty) {
      filteredlessons.value = lessons;
    } else {
      isLoading.value = true;
      filteredlessons.value = lessons.where((bank) => bank.name.contains(query)).toList();
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();

  }
}
