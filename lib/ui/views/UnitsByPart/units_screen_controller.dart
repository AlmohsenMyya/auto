import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class UnitsScreenController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;
 late List<Unit> units;
  var filteredunits = <Unit>[].obs;
  late List<Lesson> lessons;

  void readfile(int part_id) async {
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonData();
    units = JsonReader.extractUnitsByPartId(jsonfile, part_id);
    filteredunits.value = units;
    print("object ddddddddd ${units.length}");

    isLoading.value = false;
  }
  void readLesson(int unitId) async {
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonData();
    lessons = JsonReader.extractLessonByUnitId(jsonfile, unitId);

    print("object ddddddddd ${lessons.length }for unit ${unitId}");
  }

  void filterunits(String query) {
    if (query.isEmpty) {
      filteredunits.value = units;
    } else {
      isLoading.value = true;
      filteredunits.value = units.where((bank) => bank.name.contains(query)).toList();
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
  }
}
