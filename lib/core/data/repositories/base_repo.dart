import '../models/local_json/all_models.dart';

class DataHelper {
  // static List<Subject?> getSubjectsForBranch(
  //     List<Branch> branches, String branchName) {
  //   Branch? branch = branches.firstWhere(
  //           (branch) => branch.name == branchName,
  //       orElse: () => Branch(name: '', image: '', subjects: []));
  //   if (branch.name.isNotEmpty) {
  //     return branch.subjects ?? [];
  //   } else {
  //     return [];
  //   }
  // }

  // static List<Lesson>? getLessonsForCourse(
  //     Map<String, Course> courses, int courseId) {
  //   Course? course = courses[courseId.toString()];
  //   return course?.lessons ?? [];
  // }
  //
  // static List<Question> getQuestionsForCourse(
  //     Map<String, Course> questionsCourse, int courseId) {
  //   Course? course = questionsCourse[courseId.toString()];
  //   return course?.questions ?? [];
  // }
  //
  // static List<Question> getQuestionsForBank(
  //     Map<String, Bank> questionsBank, int bankId) {
  //   Bank? bank = questionsBank[bankId.toString()];
  //   return bank?.questions ?? [];
  // }
  //
  // static List<Subject> getSubjectsForPart(
  //     Map<String, List<Subject>> unitsSubject, int partId) {
  //   List<Subject> subjects = [];
  //   unitsSubject.forEach((key, value) {
  //     if (value.isNotEmpty) {
  //       subjects.addAll(value.where((subject) => subject.parts == partId));
  //     }
  //   });
  //   return subjects;
  // }

  static List<Unit> getUnitsForSubject(
      Map<String, List<Unit>> unitsPart, int subjectId) {
    List<Unit> units = [];
    unitsPart.forEach((key, value) {
      if (value.isNotEmpty) {
        units.addAll(value.where((unit) => unit.subject_id == subjectId));
      }
    });
    return units;
  }

// Add more helper methods for accessing data based on different conditions
}
