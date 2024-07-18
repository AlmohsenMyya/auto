import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';

import 'package:auto/ui/views/UnitsByPart/units_screen_view.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../courses_according_to_unit_and_lessons_screen_controller.dart';

class CoursesAccordingToUnitAndLessonsScreenCardWidget extends StatefulWidget {
  int index;
  final String subjectName;

  CoursesAccordingToUnitAndLessonsScreenCardWidget(
      {super.key, required this.subjectName, required this.index});

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
                      controller.parts[widget.index].name,
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
                          subjectName: widget.subjectName,
                          part: controller.parts[widget.index]),
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CoursesQuestionsView(
                          subjectName: widget.subjectName,
                          coursName: controller.parts[widget.index].name,
                              idPart: controller.parts[widget.index].id,
                              type: 'دورة', id_course_bank_lesson_unite: -1,
                            )));
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
        // ).onTap(() { if(controller.ifFoundPart == true){
        //   print("kdkkd ${controller.parts[widget.index].id}");
        //   Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) =>  UnitsScreen(
        //       part: controller.parts[widget.index]
        //     ),
        //   ));
        // }else{
        //
        // }
        //   print("kdkkd ${controller.parts[widget.index].id}");
        //   return Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) =>  UnitsScreen(
        //       part: controller.parts[widget.index]
        //     ),
        //   ));
        //  }
      ),
    );
  }
}
