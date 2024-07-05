import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class CoursesController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;

  late List<Course> courses;
  late List<Question> questions = <Question>[].obs;




  void readfile(int subject_id) async {
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonFromAssets('assets/data.json');
    courses = JsonReader.extractCourses(jsonfile, subject_id);
    isLoading.value = false;
  }




  @override
  void onInit() {
    super.onInit();
  }
}




