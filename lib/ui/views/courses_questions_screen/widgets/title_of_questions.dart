import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../courses_questions_controller.dart';

class TitleOfQuestions extends StatefulWidget {
  int question_index;

  TitleOfQuestions({super.key, required this.question_index});

  @override
  State<TitleOfQuestions> createState() => _TitleOfQuestionsState();
}

class _TitleOfQuestionsState extends State<TitleOfQuestions> {
  late CoursesQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 40.h,
      color: context.exOnPrimaryContainer,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.more_vert,
            ),
            10.w.horizontalSpace,
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: controller.questions[widget.question_index].text,
                  style: context.exTextTheme.subtitle1!.copyWith(
                    color: context.exOnBackground,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
