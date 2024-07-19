import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../parts_screen_controller.dart';

class PartsScreenCardWidget extends StatefulWidget {
  int index;
  final String subjectName;
  PartsScreenCardWidget({super.key, required this.index , required this.subjectName});

  @override
  State<PartsScreenCardWidget> createState() => _PartsScreenCardWidgetState();
}

class _PartsScreenCardWidgetState extends State<PartsScreenCardWidget> {
  late PartsScreenController controller;

  @override
  void initState() {
    controller = Get.put(PartsScreenController());

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
                          .copyWith(color:  context.exInversePrimaryColor),
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
        print("kdkkd ${controller.parts[widget.index].id}");
        return Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CoursesQuestionsView(
            coursName: controller.parts[widget.index].name,
            subjectName: widget.subjectName,
            id_course_bank_lesson_unite: controller.parts[widget.index].id,
            type: "دورة",
          ),
        ));
      }),
    );
  }
}