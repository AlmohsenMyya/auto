import 'package:auto2/core/services/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';

class BanksController extends BaseController {
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;
  var filteredBanks = <Bank>[].obs;
  late List<Bank> banks;



  void readfile(int subject_id) async {
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonData();
    banks = JsonReader.extractBanks(jsonfile, subject_id);
    filteredBanks.value = banks;
    isLoading.value = false;
  }

  void filterBanks(String query) {
    if (query.isEmpty) {
      filteredBanks.value = banks;
    } else {
      isLoading.value = true;
      filteredBanks.value = banks.where((bank) => bank.name.contains(query)).toList();
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
  }
}
