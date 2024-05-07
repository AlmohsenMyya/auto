import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../models/local_json/all_models.dart';

// Import the models here

class JsonReader {
  static Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }
  // static Map<String, dynamic> readDataFromJson(String filePath) {
  //   // Print current working directory
  //   print('Current working directory: ${Directory.current.path}');
  //
  //   // Print the file path being used
  //   print('File path: $filePath');
  //
  //   File file = File(filePath);
  //   print('File path: ${file.parent}${file.exists()} ${file.open().toString()}');
  //   // if (!file.existsSync()) {
  //   //   print('File does not exist!');
  //   //   return <String, dynamic>{};
  //   // }
  //
  //   String jsonString = file.readAsStringSync();
  //   return jsonDecode(jsonString);
  // }


  static List<Branch> extractBranches(Map<String, dynamic> jsonData) {
    List<Branch> branches = (jsonData['branches'] as List)
        .map((branchJson) => Branch.fromJson(branchJson))
        .toList();
    return branches;
  }

  static Map<String, List<Subject>> extractSubjects(
      Map<String, dynamic> jsonData) {
    Map<String, List<Subject>> subjects = {};
    jsonData['subjects'].forEach((key, value) {
      subjects[key] = (value as List)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList();
    });
    return subjects;
  }

  // Repeat the same for other data extraction methods...

  static List extractSliders(Map<String, dynamic> jsonData) {
    List sliders = (jsonData['sliders'] as List)
        .map((sliderJson) => Slider.fromJson(sliderJson))
        .toList();
    return sliders;
  }
  // Map<String, dynamic> jsonData = JsonReader.readDataFromJson('data.json');
  //
  // List<Branch> branches = JsonReader.extractBranches(jsonData);
  //
  // Map<String, List<Subject>> subjects = JsonReader.extractSubjects(jsonData);
  //
  // // Repeat the same for other data extraction...
  //
  // List sliders = JsonReader.extractSliders(jsonData);
}
