import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesAccordingToUnitAndLessonsCardWidget extends StatelessWidget {
  const CoursesAccordingToUnitAndLessonsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.exOnPrimaryContainer,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.h.verticalSpace,
                  Text(
                    "الدورة الاولى :",
                    style: context.exTextTheme.subtitle1!
                        .copyWith(color: context.exPrimaryColor),
                  ),
                  10.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      10.w.horizontalSpace,
                      Text(
                        'عدد الأسئلة :',
                        style: context.exTextTheme.subtitle1!
                            .copyWith(color: context.exPrimaryColor),
                      ),
                      10.w.horizontalSpace,
                      Text(
                        '23',
                        style: context.exTextTheme.subtitle1!
                            .copyWith(color: context.exPrimaryColor),
                      ),
                      0.4.sw.horizontalSpace,
                    ],
                  ),
                ],
              ),
              Center(
                child: Icon(Icons.arrow_forward_ios_rounded),
              ).exBox(height: 40, width: 20).paddingAll(10.w)
            ],
          ),
          Divider(
            height: 10.h,
            color: context.exBackground,
          )
        ],
      ),
    ).onTap(() => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CoursesQuestionsView(
            id_course_bank_lesson_unite: 1,
            type: "تيست",
          ),
        )));
  }
}
