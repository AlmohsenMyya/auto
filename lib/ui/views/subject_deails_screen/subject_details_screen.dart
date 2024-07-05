import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/Banks/banks_view.dart';
import 'package:auto/ui/views/courses/courses_view.dart';
import 'package:auto/ui/views/subject_deails_screen/widget/subject_card_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../banks_according_to_unit_and_lessons_screen/banks_according_to_units_and_lessons_screen.dart';
import '../courses_according_to_unit_and_lessons_screen/courses_according_to_unit_and_lessons_screen_view.dart';
class SubjectDetailsScreen extends StatelessWidget {
  final Subject subject;

  SubjectDetailsScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    // Courses and lessons
    List<Map<String, dynamic>> array2 = [
      {'دورات': Courses(subject: subject)},
      {'بنوك': Banks(subject: subject)},
      {'دورات حسب الوحدة والدروس': CoursesAccordingToUnitAndLessonsScreen(subject: subject)},
      {'بنوك مصنفة حسب الوحدة والدروس': BankAccordingToUnitAndLessonsScreen(subject: subject)}
    ];

    return Scaffold(
      backgroundColor: context.exOnPrimaryContainer,
      appBar: MainAppBar(
        backGroundColor: context.exOnPrimaryContainer,
        onTap: () => Get.back(),
        titleText: ' مادة ${subject.name}',
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          //fontFamily: 'Alexandria',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: GridView.builder(
          itemCount: array2.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Single column
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.4, // Adjust the aspect ratio as needed
          ),
          itemBuilder: (BuildContext context, int index) {
            return SubjectCardDetails(
              name: array2[index],
            );
          },
        ),
      ),
    );
  }
}

