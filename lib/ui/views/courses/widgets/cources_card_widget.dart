import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../courses_controller.dart';

class CoursesCardWidget extends StatefulWidget {
  int index;

  CoursesCardWidget({super.key, required this.index});

  @override
  State<CoursesCardWidget> createState() => _CoursesCardWidgetState();
}

class _CoursesCardWidgetState extends State<CoursesCardWidget> {
  late CoursesController controller;

  @override
  void initState() {
    controller = Get.put(CoursesController());

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
                      controller.courses[widget.index].name,
                      textDirection: TextDirection.ltr,
                      style: context.exTextTheme.titleMedium!
                          .copyWith(color: context.exPrimaryColor),
                    ),
                    15.h.verticalSpace,
                  ],
                ),
                Center(
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ).exBox(height: 40, width: 20)
              ],
            ),
            Divider(
              height: 10.h,
              color: context.exBackground,
            )
          ],
        ),
      ).onTap(() {
        print("kdkkd ${controller.courses[widget.index].id}");
        return Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CoursesQuestionsView(
            id_course_bank_lesson_unite: controller.courses[widget.index].id,
            type: "دورة",
          ),
        ));
      }),
    );
  }
}
