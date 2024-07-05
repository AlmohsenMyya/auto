import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/views/lesson_questions_screen/lesson_questions_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class TitleOfLessonQuestions extends StatefulWidget {
  int question_index;

  TitleOfLessonQuestions({super.key, required this.question_index});

  @override
  State<TitleOfLessonQuestions> createState() => _TitleOfLessonQuestionsState();
}

class _TitleOfLessonQuestionsState extends State<TitleOfLessonQuestions> {
  late LessonsQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(LessonsQuestionsController());
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
                  style: context.exTextTheme.titleMedium!.copyWith(
                    color: context.exOnBackground,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
