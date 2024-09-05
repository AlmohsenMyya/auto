class Branch {
  final int? branchId;
  final String name;
  final String? image;
  bool isVistor;

  Branch({
    required this.name,
    this.image,
    this.branchId,
    this.isVistor = false, // القيمة الافتراضية
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      branchId: json['id'],
      name: json['name'],
      image: json['image'],
      isVistor: json['isVistor'] ?? false, // إذا كانت القيمة موجودة في الـ JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': branchId,
      'name': name,
      'image': image,
      'isVistor': isVistor,
    };
  }
}


class Subject {
  final int? subject_id;
  final String name;
  final String? image;
  final int branch_id;

  // final List<Part>? parts;

  Subject({
    required this.subject_id,
    required this.name,
    this.image,
    required this.branch_id,
    // required this.parts,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subject_id: json['id'],
      name: json['name'],
      image: json['image'],
      branch_id: json['branch_id'],
      // parts: null
      // (json['parts'] = null) ?? (json['parts'] as List)
      // .map((partJson) => Part.fromJson(partJson))
      // .toList(),
    );
  }
}

class Part {
  final int id;
  final String name;
  final String? image;
  final int? isPublic;
  final int subject_id;

  // final List<Unit> units;

  Part({
    required this.id,
    required this.name,
    this.image,
    this.isPublic,
    required this.subject_id,
    // required this.units,
  });

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      isPublic: json['isPublic'],
      subject_id: json['subject_id'],
      // units: (json['units'] as List)
      //     .map((unitJson) => Unit.fromJson(unitJson))
      //     .toList(),
    );
  }
}

class Unit {
  final int id;
  final String name;
  final String? image;
  final int? subject_id;
  final int? part_id;

  Unit(
      {required this.id,
      required this.name,
      this.image,
      this.subject_id,
      this.part_id});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        subject_id: json['subject_id'],
        part_id: json['part_id']);
  }
}

class Lesson {
  final int id;
  final String name;
  final String? image;
  final int unit_id;
  final int? isPublic;

  Lesson({
    required this.id,
    required this.name,
    this.image,
    this.isPublic,
    required this.unit_id,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      isPublic: json['isPublic'],
      image: json['image'],
      unit_id: json['unit_id'],
    );
  }
}

class Course {
  final int id;
  final String name;
  final int is_public;
  final int subject_id;

  // final List<Lesson> lessons;
  // final List<Question> questions;

  Course({
    required this.id,
    required this.name,
    required this.is_public,
    required this.subject_id,
    // required this.lessons,
    // required this.questions,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      is_public: json['is_public'],
      subject_id: json['subject_id'],
      // lessons: (json['lessons'] as List)
      //     .map((lessonsjson) => Lesson.fromJson(lessonsjson))
      //     .toList(),
      // questions: (json['questions'] as List)
      //     .map((questionJson) => Question.fromJson(questionJson))
      //     .toList(),
    );
  }
}

class Question {
  final int id;
  final String text;
  final int? part_id;
  final int? lesson_id;
  final String? explain;
  final int? order_changing ;
  final String? image;
  final int? isPublic;
  final bool? isCourse ;


  final int? unit_id;
  final List<Answer?>? answers;

  Question( {
    required this.id,
    required this.text,
    this.part_id,
    this.lesson_id,
    this.explain,
    this.order_changing,
    this.image,
    this.unit_id,
    this.isPublic,
    this.isCourse,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      isCourse : json['status'] == "course" ? true : false,
      lesson_id: json['lesson_id'],
      isPublic: json['isPublic'],
      part_id: json['part_id'],
      unit_id: json['unit_id'],
      explain: json['explain'],
      image: json['image'],
      text: json['text'],
      order_changing:json['order_changing'],
      answers: (json['answers'] as List)
          .map((answerJson) => Answer.fromJson(answerJson))
          .toList(),
    );
  }
}

class Answer {
  final int id;
  final String text;
  final int isCorrect;

  Answer({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      text: json['text'],
      isCorrect: json['is_correct'],
    );
  }
}

class Bank {
  final int id;
  final String name;
  final int isPublic;
  final int subjectId;

  // final List<Question> questions;

  Bank({
    required this.id,
    required this.name,
    required this.isPublic,
    required this.subjectId,
    // required this.questions,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'],
      name: json['name'],
      isPublic: json['is_public'],
      subjectId: json['subject_id'],
      // questions: (json['questions'] as List)
      //     .map((questionJson) => Question.fromJson(questionJson))
      //     .toList(),
    );
  }
}

class SliderModel {
  final String imageUrl;

  SliderModel({required this.imageUrl});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      imageUrl: json['image'],
    );
  }
}

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Library {
  final int id;
  final String name;
  final int cityId;

  Library({required this.id, required this.name, required this.cityId});

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      id: json['id'],
      name: json['name'],
      cityId: json['city_id'],
    );
  }
}

