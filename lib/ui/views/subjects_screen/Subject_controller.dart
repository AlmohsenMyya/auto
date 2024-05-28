import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class SubjectController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;

  late List<Subject> subjects;

  void readfile(int branch_id) async {
    isLoading.value = true ;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonFromAssets('assets/data.json');
    subjects = JsonReader.extractSubjects(jsonfile ,branch_id );
    isLoading.value = false;
  }

  @override
  void onInit() {

    super.onInit();
  }
}
