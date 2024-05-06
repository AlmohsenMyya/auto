import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../courses_questions_controller.dart';
class AnswerLine extends StatefulWidget {
  const AnswerLine({super.key});

  @override
  State<AnswerLine> createState() => _AnswerLineState();
}

class _AnswerLineState extends State<AnswerLine> {
  late CoursesQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() =>         Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
            text: TextSpan(
                text: '-1-',
                style: context.exTextTheme.headline3!
                    .copyWith(
                    color: context.exOnBackground),
                children: [
                  TextSpan(
                      text: controller.open.value
                          ? "هذا النص فقط للاختبار "
                          : '  هذا النص فقط للاختبار',
                      style: context.exTextTheme.subtitle2!
                          .copyWith(
                          color:
                          context.exPrimaryColor))
                ])),
        Radio(
          value: '',
          groupValue: '',
          onChanged: (value) {},
        )
      ],
    ),);
  }
}
