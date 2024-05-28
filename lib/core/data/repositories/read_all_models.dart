import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../models/local_json/all_models.dart';

// Import the models here

class JsonReader {
  static Future<Map<String, dynamic>> loadJsonFromAssets(
      String filePath) async {
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

  static List<Subject> extractSubjects(
      Map<String, dynamic> jsonData, int branchId) {
    // Initialize an empty list to store subjects
    List<Subject> subjects = [];
    print(
        "+++ ${jsonData['subjects'] != null}${jsonData['subjects'][branchId.toString()] != null}");
    // Check if the subjects map contains data for the provided branch ID
    if (jsonData['subjects'] != null &&
        jsonData['subjects'][branchId.toString()] != null) {
      // Extract subjects for the provided branch ID
      subjects = (jsonData['subjects'][branchId.toString()] as List)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList();
      print("hb hjb jhb $subjects");
    }

    return subjects;
  }

  static List<Course> extractCourses(
      Map<String, dynamic> jsonData, int subjectId) {
    // Initialize an empty list to store courses
    List<Course> courses = [];

    // Check if the courses map contains data for the provided subject ID
    if (jsonData['courses'] != null &&
        jsonData['courses'][subjectId.toString()] != null) {
      // Extract courses for the provided subject ID
      courses = (jsonData['courses'][subjectId.toString()] as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
    }
    print("courses JsonReader ${courses.length}");
    return courses;
  }

  static List<Bank> extractBanks(Map<String, dynamic> jsonData, int subjectId) {
    // Initialize an empty list to store courses
    List<Bank> banks = [];

    // Check if the courses map contains data for the provided subject ID
    if (jsonData['banks'] != null &&
        jsonData['banks'][subjectId.toString()] != null) {
      // Extract courses for the provided subject ID
      banks = (jsonData['banks'][subjectId.toString()] as List)
          .map((courseJson) => Bank.fromJson(courseJson))
          .toList();
    }
    print("bank JsonReader ${banks.length}");
    return banks;
  }

  // static List<Part> extractParts(Map<String, dynamic> jsonData, int subjectId) {
  //   List<Part> parts = [];
  //   if (jsonData['parts'] != null && jsonData['parts'][subjectId.toString()] != null) {
  //     parts = (jsonData['parts'][subjectId.toString()] as List)
  //         .map((partJson) => Part.fromJson(partJson))
  //         .toList();
  //   }
  //   print("Parts count: ${parts.length}");
  //
  //   if (parts.isNotEmpty) {
  //     for (var part in parts) {
  //       int partId = part.id;
  //       if (jsonData['units'] != null && jsonData['units'][partId.toString()] != null) {
  //         var unitJsonList = jsonData['units'][partId.toString()] as List;
  //         List<Unit> units = unitJsonList.map((unitJson) => Unit.fromJson(unitJson)).toList();
  //         print("Units for partId $partId: ${units.length}");
  //
  //         // Process the units as needed, e.g., add them to the part or another data structure
  //       }
  //     }
  //   }
  //
  //   return parts;
  // }
  static bool findPartByID(Map<String, dynamic> jsonData, int subjectId) {
    List<Part>? parts = [];
    if (jsonData['parts'] != null &&
        jsonData['parts'][subjectId.toString()] != null) {
      parts = (jsonData['parts'][subjectId.toString()] as List).cast<Part>();
      if (parts.isNotEmpty) {
        print("there is parts for subject ${subjectId}");
        return true;
      } else {
        print("there is no parts for subject $subjectId");
        return false;
      }
    }
    return false ;
  }

  static List<Part> extractParts(Map<String, dynamic> jsonData, int subjectId) {
    List<Part> parts = [];
    parts = (jsonData['parts'][subjectId.toString()] as List)
        .map((partJson) => Part.fromJson(partJson))
        .toList();
    print("Parts count: ${parts.length}");

    return parts;

    return [];
  }

  static List<Unit> extractUnitsByPartId(
      Map<String, dynamic> jsonData, int partId) {
    List<Unit> units = [];
    if (jsonData['units_part'] != null &&
        jsonData['units_part'][partId.toString()] != null) {
      var unitJsonList = jsonData['units_part'][partId.toString()] as List;
      units = unitJsonList.map((unitJson) => Unit.fromJson(unitJson)).toList();
    }
    print("Units count for PartI : ${units.length}");
    return units;
  }

  static List<Unit> extractUnitsBySubjectId(
      Map<String, dynamic> jsonData, int subjectId) {
    List<Unit> units = [];
    if (jsonData['units_subject'] != null &&
        jsonData['units_subject'][subjectId.toString()] != null) {
      var unitJsonList =
          jsonData['units_subject'][subjectId.toString()] as List;
      units = unitJsonList.map((unitJson) => Unit.fromJson(unitJson)).toList();
    }
    print("Unit subjects count: ${units.length}");
    return units;
  }

  static List<Question> extractQuestionsByCourseId(
      Map<String, dynamic> jsonData, int courseId) {
    // Initialize an empty list to store questions
    List<Question> questions = [];

    // Check if the questions_course map contains data for the provided course ID
    if (jsonData['questions_course'] != null &&
        jsonData['questions_course'][courseId.toString()] != null) {
      // Extract course data for the provided course ID
      var courseData = jsonData['questions_course'][courseId.toString()];
      // Check if questions are available for the course
      if (courseData['questions'] != null) {
        // Extract questions for the course
        questions = (courseData['questions'] as List)
            .map((questionJson) => Question.fromJson(questionJson))
            .toList();
      }
    }

    return questions;
  }

  static List<Part> extractpartsBySubjectId(
      Map<String, dynamic> jsonData, int subjectId) {
    // Initialize an empty list to store questions
    List<Part> parts = [];
    if (jsonData['parts'] != null &&
        jsonData['parts'][subjectId.toString()] != null) {
      var partsData = jsonData['parts'][subjectId.toString()];
      if (partsData['parts'] != null) {
        parts = (partsData['parts'] as List)
            .map((unitJson) => Part.fromJson(unitJson))
            .toList();
      }
    }
    print("parrrts $parts");
    return parts;
  }

  static List<Question> extractQuestionsByBankId(
      Map<String, dynamic> jsonData, int courseId) {
    // Initialize an empty list to store questions
    List<Question> questions = [];

    // Check if the questions_course map contains data for the provided course ID
    if (jsonData['questions_bank'] != null &&
        jsonData['questions_bank'][courseId.toString()] != null) {
      // Extract course data for the provided course ID
      var courseData = jsonData['questions_bank'][courseId.toString()];
      // Check if questions are available for the course
      if (courseData['questions'] != null) {
        // Extract questions for the course
        questions = (courseData['questions'] as List)
            .map((questionJson) => Question.fromJson(questionJson))
            .toList();
      }
    }

    return questions;
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
