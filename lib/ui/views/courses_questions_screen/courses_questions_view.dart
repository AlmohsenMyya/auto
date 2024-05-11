import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/courses_questions_screen/widgets/quesion_tile_widget.dart';
import 'package:auto/ui/views/courses_questions_screen/widgets/timer_litsner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../shared/colors.dart';
import '../../shared/flutter_switch.dart';
import 'courses_questions_controller.dart';

class CoursesQuestionsView extends StatefulWidget {
  int id_course_bank_lesson_unite;
String type ;
  CoursesQuestionsView({super.key, required this.id_course_bank_lesson_unite,required this.type});

  @override
  State<CoursesQuestionsView> createState() => _CoursesQuestionsViewState();
}

class _CoursesQuestionsViewState extends State<CoursesQuestionsView> {
  late CoursesQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());
    controller.readfile(widget.id_course_bank_lesson_unite , widget.type);
    controller.initializeExpandedQuestions();
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
                      !controller.openExpand.value
                          ? controller.startExpandAll()
                          : controller.stopExpandAll();
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
              Obx(
                () => controller.isLoading.value
                    ? SpinKitThreeBounce(
                        color: AppColors.blueB4,
                        size: 50.0,
                      )
                    : Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          // key: controller.settingsButtonKey,
                          itemBuilder: (context, question_index) {
                            return QuestionTileWidget(
                              question_index: question_index,
                            );
                          },
                          itemCount: controller.questions.length,
                        ),
                      ),
              )
            ],
          ).paddingHorizontal(10.w);
        },
      ),
    );
  }
}
