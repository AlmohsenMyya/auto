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

  static List<Subject> extractSubjects(Map<String, dynamic> jsonData, int branchId) {
    // Initialize an empty list to store subjects
    List<Subject> subjects = [];
print("+++ ${jsonData['subjects'] != null }${jsonData['subjects'][branchId.toString()] != null}");
    // Check if the subjects map contains data for the provided branch ID
    if (jsonData['subjects'] != null && jsonData['subjects'][branchId.toString()] != null) {
      // Extract subjects for the provided branch ID
      subjects = (jsonData['subjects'][branchId.toString()] as List)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList();
      print("hb hjb jhb $subjects");
    }

    return subjects;
  }

  static List<Course> extractCourses(Map<String, dynamic> jsonData, int subjectId) {
    // Initialize an empty list to store courses
    List<Course> courses = [];

    // Check if the courses map contains data for the provided subject ID
    if (jsonData['courses'] != null && jsonData['courses'][subjectId.toString()] != null) {
      // Extract courses for the provided subject ID
      courses = (jsonData['courses'][subjectId.toString()] as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
    }
print("jjjjjjjjjjjj ${courses.length}");
    return courses;
  }
  // Repeat the same for other data extraction methods...

  static List extractSliders(Map<String, dynamic> jsonData) {
    List sliders = (jsonData['sliders'] as List)
        .map((sliderJson) => Slider.fromJson(sliderJson))
        .toList();
    return sliders;
  }
  // Map<String, dynamic> jsonData = JsonReader.readDataFromJson('data1.json');
  //
  // List<Branch> branches = JsonReader.extractBranches(jsonData);
  //
  // Map<String, List<Subject>> subjects = JsonReader.extractSubjects(jsonData);
  //
  // // Repeat the same for other data extraction...
  //
  // List sliders = JsonReader.extractSliders(jsonData);
}
