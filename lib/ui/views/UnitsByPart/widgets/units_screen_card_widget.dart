import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../lessons/lesson_screen_view.dart';
import '../../units_question_screen/units_questions_view.dart';
import '../units_screen_controller.dart';

class UnitsScreenCardWidget extends StatefulWidget {
  int index;

  UnitsScreenCardWidget({super.key, required this.index});

  @override
  State<UnitsScreenCardWidget> createState() => _UnitsScreenCardWidgetState();
}

class _UnitsScreenCardWidgetState extends State<UnitsScreenCardWidget> {
  late UnitsScreenController controller;

  @override
  void initState() {
    controller = Get.put(UnitsScreenController());

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
                      controller.units[widget.index].name ,
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
                    "عرض الدروس",
                    textAlign: TextAlign.start,
                    style: context.exTextTheme.titleMedium!
                        .copyWith(color: context.exInversePrimaryColor,fontSize: 15.sp),

                  ),
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context ) => LessonScreen(unit: controller.units[widget.index],)));},
                ),
                SizedBox(width: 15,),
                InkWell(
                  child: Text(
                    "عرض الأسئلة",
                    textAlign: TextAlign.start,
                    style: context.exTextTheme.titleMedium!
                        .copyWith(color: context.exInversePrimaryColor,fontSize: 15.sp),

                  ),
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(
                      builder: (context ) =>
                          UnitsQuestionsView(idUnit: controller.units[widget.index].id,type: "test",)));},
                ),
                SizedBox(width: 10), // لإضافة مسافة بين النص والسهم
                // Center(()
                //   child: Icon(Icons.arrow_forward_ios_rounded),
                // ).exBox(height: 40, width: 20),
              ],
            )
            ,
            Divider(
              height: 10.h,
              color: context.exBackground,
            )
          ],
        ),
      ).onTap(() {
        // print("kdkkd ${controller.units[widget.index].id}");
        // return Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => CoursesQuestionsView(
        //     id_course_bank_lesson_unite: controller.units[widget.index].id,
        //     type: "دورة",
        //   ),
        // ));
      }),
    );
  }
}
