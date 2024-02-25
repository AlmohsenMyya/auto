import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/courses_according_to_unit_and_lessons_screen/courses_according_to_unit_and_lessons_screen_view.dart';
import 'package:auto/ui/views/subject_deails_screen/widget/subject_card_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectDetailsScreen extends StatelessWidget {
  const SubjectDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Courses and lessons
    List<Map<String, dynamic>> array2 = [
      {'دورات': null},
      {'بنوك': null},
      {'دورات حسب الوحدة والدروس': CoursesAccordingToLessonsAndUnitView()},
      {'بنوك مصنفة حسب الوحدة والدروس': null}
    ];
    return Scaffold(
      appBar: MainAppBar(
          onTap: () => Get.back(),
          titleText: 'تفاصيل المادة',
          titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Alexandria')),
      body: Column(children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: array2.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 100,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SubjectCardDetails(
                name: array2[index],
              );
            },
          ),
        ))
      ]),
    );
  }
}
