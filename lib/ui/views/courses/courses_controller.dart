import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';
import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class CoursesController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;
  var filteredcourses = <Course>[].obs;
  late List<Course> courses;
  late List<Question> questions = <Question>[].obs;
  var courseQuestionsCount = <int, int>{}.obs; // لتخزين عدد الأسئلة لكل دورة

  void readfile(int subject_id) async {
    isLoading.value = true;
    jsonfile = await JsonReader.loadJsonData();
    courses = JsonReader.extractCourses(jsonfile, subject_id);
    filteredcourses.value = courses;
    await _calculateQuestionsCount(); // حساب عدد الأسئلة لكل دورة
    isLoading.value = false;
  }

  void filtercourses(String query) {
    if (query.isEmpty) {
      filteredcourses.value = courses;
    } else {
      isLoading.value = true;
      filteredcourses.value = courses.where((course) => course.name.contains(query)).toList();
      isLoading.value = false;
    }
  }

  Future<void> _calculateQuestionsCount() async {
    for (var course in filteredcourses) {
      int id = course.id;
      var questions = JsonReader.extractQuestionsByCourseId(jsonfile, id);
      courseQuestionsCount[id] = questions.length;
    }
  }

  int getQuestionsCount(int courseId) {
    return courseQuestionsCount[courseId] ?? 0;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
