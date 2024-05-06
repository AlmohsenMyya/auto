import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/courses_questions_screen/widgets/quesion_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        onTap: () => Get.back(), titleText:  'الاسئلة',
      ),
      body:  GetBuilder<CoursesQuestionsController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              10.h.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'دورة 2018',
                    key: controller.floatingButtonKey,
                    style: context.exTextTheme.subtitle1!
                        .copyWith(color: context.exPrimaryColor),
                  ),
                  Text(
                    'علوم',
                    style: context.exTextTheme.headline3!
                        .copyWith(color: context.exOnBackground),
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller.outSideCounter,
                    builder: (context, value, child) {
                      return value
                          ? () {
                        controller.outSideEndTime =
                            DateTime.now().millisecondsSinceEpoch +
                                1000 * controller.outSideSecondsDuration;
                        controller.timeControllerOutSide =
                            CountdownTimerController(
                                endTime: controller.outSideEndTime,
                                onEnd: controller.onEndTimeOutSide);

                        return Container(
                          width: 50.w,
                          height: 50.h,
                          child: Center(
                            child: CountdownTimer(
                              onEnd: controller.onEndTimeOutSide,
                              controller: controller.timeControllerOutSide,
                              widgetBuilder: (context, time) =>
                                  Text('${time!.sec}'),
                            ),
                          ),
                        );
                      }()
                          : SizedBox(width: 50.w, height: 50.h);
                    },
                  ),
                ],
              ),
              10.h.verticalSpace,
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
           Obx(() =>    Row(children: [
             Checkbox(
               value: controller.open.value,
               onChanged: (value) {
                 print("${controller.open.value}");
                 controller.open.value = !controller.open.value;
               },
             ),
             Text(
               controller.open.value ? 'إخفاء الأجوبة' : 'إظهار الأجوبة',
               style: context.exTextTheme.subtitle1!
                   .copyWith(color: context.exPrimaryColor),
             )
           ]),),
              Expanded(
                child: ListView.builder(
                  key: controller.settingsButtonKey,
                  itemBuilder: (context, index) {
                    return  QuestionTileWidget(

                    );
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
