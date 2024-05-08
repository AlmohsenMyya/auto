import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/courses_questions_screen/widgets/quesion_tile_widget.dart';
import 'package:auto/ui/views/courses_questions_screen/widgets/timer_litsner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../shared/flutter_switch.dart';
import 'courses_questions_controller.dart';

class CoursesQuestionsView extends StatefulWidget {
  const CoursesQuestionsView({super.key});

  @override
  State<CoursesQuestionsView> createState() => _CoursesQuestionsViewState();
}

class _CoursesQuestionsViewState extends State<CoursesQuestionsView> {
  late CoursesQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        onTap: () => Get.back(),
        titleText: 'الاسئلة',
      ),

      body: GetBuilder<CoursesQuestionsController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              30.h.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  2.horizontalSpace,
                  Text(
                    'علوم',
                    style: context.exTextTheme.subtitle1!
                        .copyWith(color: context.exPrimaryColor),
                  ),
                  Text(
                    'دورة 2018',
                    key: controller.floatingButtonKey,
                    style: context.exTextTheme.subtitle1!
                        .copyWith(color: context.exPrimaryColor),
                  ),
                  RichText(
                    key: controller.editButtonKey,
                    text: TextSpan(
                      text: 'عدد الاسئلة : ',
                      style: context.exTextTheme.subtitle1!
                          .copyWith(color: context.exPrimaryColor),
                      children: [
                        TextSpan(
                          text: '21',
                          style: context.exTextTheme.subtitle1!
                              .copyWith(color: context.exPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                  2.horizontalSpace,
                ],
              ),
              20.h.verticalSpace,
              Obx(
                () => Row(children: [
                  Checkbox(
                    value: controller.openExpand.value,
                    onChanged: (value) {
                      print("${controller.openExpand.value}");
                      controller.openExpand.value =
                          !controller.openExpand.value;
                    },
                  ),
                  Text(
                    controller.openExpand.value
                        ? 'إخفاء الأجوبة'
                        : 'إظهار الأجوبة',
                    style: context.exTextTheme.subtitle1!
                        .copyWith(color: context.exPrimaryColor, fontSize: 13),
                  ),
                  10.verticalSpace,
                  Checkbox(
                    value: !controller.answerTheQuestion.value,
                    onChanged: (value) {
                      print("${controller.answerTheQuestion.value}");
                      controller.answerTheQuestion.value =
                          !controller.answerTheQuestion.value;
                    },
                  ),
                  Text(
                    controller.answerTheQuestion.value
                        ? 'إظهار الحل'
                        : 'إخفاء الحل',
                    style: context.exTextTheme.subtitle1!
                        .copyWith(color: context.exPrimaryColor, fontSize: 13),
                  ),
                  10.verticalSpace,
                  Spacer(),
                  TimerListener()
                ]),
              ),
              Expanded(
                child: ListView.builder(
                  key: controller.settingsButtonKey,
                  itemBuilder: (context, index) {
                    return QuestionTileWidget( );
                  },
                  itemCount: 21,
                ),
              ),
            ],
          ).paddingHorizontal(10.w);
        },
      ),
    );
  }
}
