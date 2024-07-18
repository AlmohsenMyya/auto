import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class LessonScreenController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;
  RxList<Unit> units = <Unit>[].obs;
  RxList<Lesson> lessons = <Lesson>[].obs;
  //
  // void readfile(int unit_id) async {
  //   isLoading.value = true;
  //   jsonfile = await JsonReader.loadJsonData();
  //   lessons.assignAll(JsonReader.extractLessonByUnitId(jsonfile, unit_id));
  //   print("object ddddddddd ${lessons.length}");
  //   isLoading.value = false;
  // }

  void readLesson(int unitId) async {
    isLoading.value = true;
    jsonfile = await JsonReader.loadJsonData();
    lessons.assignAll(JsonReader.extractLessonByUnitId(jsonfile, unitId));
    print("object ddddddddd ${lessons.length} for unit $unitId");
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();

  }
}
