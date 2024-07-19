import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/local_json/all_models.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// Import the models here

class JsonReader {
  // static Future<Map<String, dynamic>> loadJsonFromAssets(
  //     String filePath) async {
  //   String jsonString = await rootBundle.loadString(filePath);
  //   return jsonDecode(jsonString);
  // }

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
    return false;
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

  static List<City> extractCities(Map<String, dynamic> jsonData) {
    List<City> cities = [];
    if (jsonData['cities'] != null) {
      cities = (jsonData['cities'] as List)
          .map((cityJson) => City.fromJson(cityJson))
          .toList();
    }
    return cities;
  }

  static List<Library> extractLibraries(
      Map<String, dynamic> jsonData, int cityId) {
    List<Library> libraries = [];
    if (jsonData['libraries'] != null) {
      libraries = (jsonData['libraries'] as List)
          .map((libraryJson) => Library.fromJson(libraryJson))
          .where((library) => library.cityId == cityId)
          .toList();
    }
    return libraries;
  }

  static List<Question> extractQuestions(
      Map<String, dynamic> jsonData, int key, String type, bool isCourse) {

    List<Question> questions = [];

    if (jsonData['questions'] != null) {
      var questionList = jsonData['questions'] as List<dynamic>;

      if (type == 'unit') {
        questions = questionList
            .where((question) =>
        question['unit_id'] == key &&
            (isCourse ? question['status'] == 'course' : question['status'] != 'course'))
            .map((questionJson) => Question.fromJson(questionJson))
            .toList();
      } else if (type == 'lesson') {
        questions = questionList
            .where((question) =>
        question['lesson_id'] == key &&
            (isCourse ? question['status'] == 'course' : question['status'] != 'course'))
            .map((questionJson) => Question.fromJson(questionJson))
            .toList();
      } else if (type == 'part') {
        questions = questionList
            .where((question) =>
        question['part_id'] == key &&
            (isCourse ? question['status'] == 'course' : question['status'] != 'course'))
            .map((questionJson) => Question.fromJson(questionJson))
            .toList();
      } else {
        print("Invalid type: $type");
      }
    } else {
      print("No questions found in the JSON data");
    }

    print("Number of questions extracted: ${questions.length}");
    return questions;
  }

  static Question? extractOneQuestionById(String id, Map<String, dynamic> jsonData) {
    Question? question;

    print("extractOneQuestionById --- id $id");

    if (jsonData['questions'] != null) {
      var questionList = jsonData['questions'] as List<dynamic>;

      var foundQuestion = questionList.firstWhere(
            (question) => question['id'].toString() == id,
        orElse: () => null,
      );

      print("extractOneQuestionById --- found $foundQuestion");

      if (foundQuestion != null) {
        question = Question.fromJson(foundQuestion as Map<String, dynamic>);
      }
    } else {
      print("No questions found in the JSON data");
    }

    print("extractOneQuestionById extracted: $question");
    return question;
  }
  static List<Question> extractQuestionsByIdListAndSubjectID(
      List<String> idList, int subjectID , Map<String, dynamic> jsonData) {
    List<Question> questions = [];
    print("loadFavorites --- count ${idList.length}");
    if (jsonData['questions'] != null) {
      var questionList = jsonData['questions'] as List<dynamic>;

      for (var id in idList) {
        var foundQuestion = questionList.firstWhere(
              (question) => question['id'].toString() == id &&
                  question['subject_id'].toString() == subjectID.toString(),
          orElse: () => null,
        );
        print("loadFavorites --- found $foundQuestion");
        if (foundQuestion != null) {
          questions.add(Question.fromJson(foundQuestion));
        }
      }
    } else {
      print("No questions found in the JSON data");
    }

    print("Number of questions extracted by ID list: ${questions.length}");
    return questions;
  }
  static List<Question> extractQuestionsByIdList(
      List<String> idList, Map<String, dynamic> jsonData) {
    List<Question> questions = [];
    print("loadFavorites --- count ${idList.length}");
    if (jsonData['questions'] != null) {
      var questionList = jsonData['questions'] as List<dynamic>;

      for (var id in idList) {
        var foundQuestion = questionList.firstWhere(
          (question) => question['id'].toString() == id,
          orElse: () => null,
        );
        print("loadFavorites --- found $foundQuestion");
        if (foundQuestion != null) {
          questions.add(Question.fromJson(foundQuestion));
        }
      }
    } else {
      print("No questions found in the JSON data");
    }

    print("Number of questions extracted by ID list: ${questions.length}");
    return questions;
  }

  static List<Question> extractQuestionsByUnitId(
      Map<String, dynamic> jsonData, int unitId, bool isCourse) {
    print("Question By Unit Id $unitId");
    return extractQuestions(jsonData, unitId, 'unit',isCourse);
  }

  static List<Question> extractQuestionsByLessonId(
      Map<String, dynamic> jsonData, int lessonId , bool isCourse) {
    print("Question By Lesson Id $lessonId");
    return extractQuestions(jsonData, lessonId, 'lesson',isCourse);
  }

  static List<Question> extractQuestionsByPartId(
      Map<String, dynamic> jsonData, int partId , bool isCourse) {
    print("Question By Part Id $partId");
    return extractQuestions(jsonData, partId, 'part',isCourse);
  }

  static List<Lesson> extractLessonByUnitId(
      Map<String, dynamic> jsonData, int unitId) {
    List<Lesson> lessons = [];
    if (jsonData['lessons'] != null &&
        jsonData['lessons'][unitId.toString()] != null) {
      var lessonJsonList = jsonData['lessons'][unitId.toString()] as List;
      lessons = lessonJsonList
          .map((lessonJson) => Lesson.fromJson(lessonJson))
          .toList();
    }
    print("lesson JsonReader ${lessons.length}");
    return lessons;
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
  static void shareQuestion(String id) async {
    print("Processing video with ID: $id");

    // إزالة أي بادئة غير ضرورية من سلسلة Base64
    Uri? imageUrl = Uri.tryParse("https://firebasestorage.googleapis.com/v0/b/auto-2b136.appspot.com/o/logo.png?alt=media&token=124ffb8a-b004-4b4d-8e97-65134cfa91aa");

    print("Thumbnail: ''''  $id fff $imageUrl");
    // Configure dynamic link parameters
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://autoapp.page.link?myQuestion=$id"),
      uriPrefix: "https://autoapp.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.example.auto",
        // minimumVersion: 30,
      ),
      iosParameters: const IOSParameters(
        bundleId: "com.example.auto",
        // appStoreId: "123456789",
        // minimumVersion: "1.0.1",
      ),
      // googleAnalyticsParameters: const GoogleAnalyticsParameters(
      //   source: "twitter",
      //   medium: "social",
      //   campaign: "example-promo",
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "تطبيق اوتو .. خيارك الافضل للنجاح",
        description: "انقر على الرابط لعرض السؤال",
        imageUrl: imageUrl,
      ),
    );
    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    // Share the short URL
    Share.share(dynamicLink.shortUrl.toString());

    // Update the state to reflect the share
  }
  // static List<Answer?> shuffleAnswers(List<Answer?> answers) {
  //   print("answer12 before $answers");
  //   final random = Random();
  //   List<Answer> randomizedAnswers = List.from(answers);
  //   randomizedAnswers.shuffle(random);
  //   print("answer12 after $randomizedAnswers");
  //   return randomizedAnswers;
  // }
  static final String url1 = 'https://auto-sy.com/api/all';

 static Future<void> fetchDataAndStore() async {
    try {
      final response = await http.get(Uri.parse(url1));
      print("gfncgfncgc ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _storeDataInJsonFile(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

 static Future<void> _storeDataInJsonFile(dynamic data) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/assets/mohsen.json';
      final file = File(filePath);
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode(data));
      print('Data stored in $filePath');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jsonFilePath',filePath);
    } catch (e) {
      print('Error storing data: $e');
    }
  }
  // Load JSON data from assets
  static Future<Map<String, dynamic>> loadJsonFromAssets(String path) async {
    final data = await rootBundle.loadString(path);
    return jsonDecode(data);
  }

  // Load JSON data from a file
  static Future<Map<String, dynamic>> loadJsonFromFile(String filePath) async {
    final file = File(filePath);
    final data = await file.readAsString();
    return jsonDecode(data);
  }

  // New method to load JSON data
  static Future<Map<String, dynamic>> loadJsonData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonFilePath = prefs.getString('jsonFilePath');
print("bh hjb jhbj jsonFilePath != null${jsonFilePath }  ");
    if (jsonFilePath != null && await File(jsonFilePath).exists()) {
      // Load from file
      print('Loading data from file: $jsonFilePath');
      return await loadJsonFromFile(jsonFilePath);
    } else {
      // Load from assets
      print('Loading data from assets');
      return await loadJsonFromAssets('assets/data.json');
    }
  }
}


