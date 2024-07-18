import 'package:auto/core/services/base_controller.dart';
import 'package:get/get.dart';

import '../../../../core/data/models/local_json/all_models.dart';
import '../../../../core/data/repositories/read_all_models.dart';

class CentersController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;

  late List<City> cities = [];
  var selectedCityLibraries = <Library>[].obs;

  void readCities() async {
    isLoading.value = true;
    jsonfile = await JsonReader.loadJsonData();
    cities = JsonReader.extractCities(jsonfile);
    isLoading.value = false;
  }

  void selectCity(int cityId) {
    selectedCityLibraries.assignAll(
      JsonReader.extractLibraries(jsonfile, cityId),
    );
  }

  @override
  void onInit() {
    readCities();
    super.onInit();
  }
}
