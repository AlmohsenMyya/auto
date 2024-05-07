class Branch {
  final String name;
  final String? image;
  // final List<Subject?> subjects;

  Branch({
    required this.name,
    this.image,
    // required this.subjects,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      name: json['name'],
      image: json['image'],
      // subjects: (json['subjects'] as List)
      //     .map((subjectJson) => Subject.fromJson(subjectJson))
      //     .toList(),
    );
  }
}

class Subject {
  final int id;
  final String name;
  final String? image;
  final int branchId;
  final List<Part> parts;

  Subject({
    required this.id,
    required this.name,
    this.image,
    required this.branchId,
    required this.parts,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      branchId: json['branch_id'],
      parts: (json['parts'] as List)
          .map((partJson) => Part.fromJson(partJson))
          .toList(),
    );
  }
}

class Part {
  final int id;
  final String name;
  final String? image;
  final int subjectId;
  final List<Unit> units;

  Part({
    required this.id,
    required this.name,
    this.image,
    required this.subjectId,
    required this.units,
  });

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      subjectId: json['subject_id'],
      units: (json['units'] as List)
          .map((unitJson) => Unit.fromJson(unitJson))
          .toList(),
    );
  }
}

class Unit {
  final int id;
  final String name;
  final String? image;
  final int subjectId;

  Unit({
    required this.id,
    required this.name,
    this.image,
    required this.subjectId,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      subjectId: json['subject_id'],
    );
  }
}

class Lesson {
  final int id;
  final String name;
  final String? image;
  final int unitId;

  Lesson({
    required this.id,
    required this.name,
    this.image,
    required this.unitId,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      unitId: json['unit_id'],
    );
  }
}

class Course {
  final int id;
  final String name;
  final int isPublic;
  final int subjectId;
  final List<Lesson> lessons;
  final List<Question> questions;

  Course({
    required this.id,
    required this.name,
    required this.isPublic,
    required this.subjectId,
    required this.lessons,
    required this.questions,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      isPublic: json['is_public'],
      subjectId: json['subject_id'],
      lessons: (json['lessons'] as List)
          .map((lessonsjson) => Lesson.fromJson(lessonsjson))
          .toList(),
      questions: (json['questions'] as List)
          .map((questionJson) => Question.fromJson(questionJson))
          .toList(),
    );
  }
}

class Question {
  final int id;
  final String text;
  final List<Answer> answers;

  Question({
    required this.id,
    required this.text,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      text: json['text'],
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
  final List<Question> questions;

  Bank({
    required this.id,
    required this.name,
    required this.isPublic,
    required this.subjectId,
    required this.questions,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'],
      name: json['name'],
      isPublic: json['is_public'],
      subjectId: json['subject_id'],
      questions: (json['questions'] as List)
          .map((questionJson) => Question.fromJson(questionJson))
          .toList(),
    );
  }
}

class Slider {
  static fromJson(sliderJson) {
    return Slider();
  }
// Define properties for Slider class if needed
// (It's not clear from the provided JSON)
}
