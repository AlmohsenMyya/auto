import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../courses_questions_controller.dart';

class TitleOfQuestions extends StatefulWidget {
  const TitleOfQuestions({super.key});

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
    return Obx(
          () =>  Container(
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
                  RichText(
                      text: TextSpan(
                          text: controller.openExpand.value ?'السؤال الاول :': 'السؤال الاول :',
                          style: context.exTextTheme.subtitle1!
                              .copyWith(
                              color: context.exOnBackground),
                          children: [
                            TextSpan(
                                text: 'هذا النص فقط للاختبار',
                                style: context.exTextTheme.subtitle2!
                                    .copyWith(
                                    color:
                                    context.exPrimaryColor))
                          ])),
                ]),
          ),
    );
  }
}
