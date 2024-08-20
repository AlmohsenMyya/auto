import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';

import 'package:auto/ui/views/UnitsByPart/units_screen_view.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/data/models/local_json/all_models.dart';
import '../../login_screen/login_view.dart';
import '../courses_according_to_unit_and_lessons_screen_controller.dart';

class CoursesAccordingToUnitAndLessonsScreenCardWidget extends StatefulWidget {
  int index;
  final String subjectName;
  Branch branch;
  CoursesAccordingToUnitAndLessonsScreenCardWidget(
      {super.key, required this.subjectName,required this.branch, required this.index});

  @override
  State<CoursesAccordingToUnitAndLessonsScreenCardWidget> createState() =>
      _CoursesAccordingToUnitAndLessonsScreenCardWidgetState();
}

class _CoursesAccordingToUnitAndLessonsScreenCardWidgetState
    extends State<CoursesAccordingToUnitAndLessonsScreenCardWidget> {
  late CoursesAccordingToUnitAndLessonsScreenController controller;

  @override
  void initState() {
    controller = Get.put(CoursesAccordingToUnitAndLessonsScreenController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: context.exOnPrimaryContainer,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.h.verticalSpace,
                    Text(
                      controller.filteredparts[widget.index].name,
                      textDirection: TextDirection.ltr,
                      style: context.exTextTheme.titleMedium!
                          .copyWith(color: context.exInversePrimaryColor),
                    ),
                    15.h.verticalSpace,
                  ],
                ),
                Spacer(),
                InkWell(
                  child: Text(
                    "عرض الوحدات ",
                    textDirection: TextDirection.ltr,
                    style: context.exTextTheme.titleMedium!.copyWith(
                        color: context.exInversePrimaryColor, fontSize: 15.sp),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UnitsScreen(
                          type_isCourse: "دورة",
                          branch: widget.branch,
                          subjectName: widget.subjectName,
                          part: controller.filteredparts[widget.index]),
                    ));
                  },
                ),
                SizedBox(
                  width: 15,
                ),

                InkWell(
                  child: Text(
                    "عرض الأسئلة ",
                    textDirection: TextDirection.ltr,
                    style: context.exTextTheme.titleMedium!.copyWith(
                        color: context.exInversePrimaryColor, fontSize: 15.sp),
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final token = await prefs.getString('access_token');
                    // تحقق من is_public قبل السماح بالدخول
                    if (
                        token == null) {
                      // عرض رسالة بسيطة وزر الاشتراك
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'لا يمكن الدخول',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: context.exPrimaryContainer),
                            ),
                            content: Text(
                              'يتطلب الدخول الاشتراك. يرجى الاشتراك للاستمرار.',
                              style:
                                  TextStyle(color: context.exPrimaryContainer),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'اشتراك',
                                  style: TextStyle(
                                      color: context.exPrimaryContainer),
                                ),
                                onPressed: () {
                                  // توجيه المستخدم لصفحة تسجيل الدخول
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CoursesQuestionsView(
                                subjectName: widget.subjectName,
                                coursName:
                                    controller.filteredparts[widget.index].name,
                                idPart:
                                    controller.filteredparts[widget.index].id,
                                type: 'دورة',
                                id_course_bank_lesson_unite: -1,
                              )));
                    }
                  },
                ),
                15.h.verticalSpace,
                // Center(
                //   child: Icon(Icons.arrow_forward_ios_rounded),
                // ).exBox(height: 40, width: 20)
              ],
            ),
            Divider(
              height: 10.h,
              color: context.exBackground,
            )
          ],
        ),
      ),
    );
  }
}
