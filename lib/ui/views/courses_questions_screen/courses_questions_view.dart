import 'dart:async';
import 'dart:developer';

import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/shared/flutter_switch.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/courses_questions_screen/widgets/quesion_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesQuestionsView extends StatefulWidget {
  const CoursesQuestionsView({super.key});

  @override
  State<CoursesQuestionsView> createState() => _CoursesQuestionsViewState();
}

class _CoursesQuestionsViewState extends State<CoursesQuestionsView> {
  late int endTime = 1;
  ExpansionTileController expController = ExpansionTileController();
  late int outSideEndTime = 1;
  late CountdownTimerController _timeController =
      CountdownTimerController(endTime: endTime);
  int secondsDuration = 4;
  int outSideSecondsDuration = 4;
  ValueNotifier<bool> timerStatus = ValueNotifier(false);
  ValueNotifier<bool> isTimerCounterCountDownActive = ValueNotifier(false);
  ValueNotifier<bool> animatedOpacityCounterValue = ValueNotifier(false);
  ValueNotifier<bool> outSideCounter = ValueNotifier(false);
  ValueNotifier<bool> expansionTile = ValueNotifier(false);
  bool open = true;
  Timer? timer;

  late CountdownTimerController _timeControllerOutSide =
      CountdownTimerController(endTime: endTime, onEnd: onEnd);

  void onEnd() {
    log("the timer end ", name: 'timer');

    _timeControllerOutSide.dispose();
    _timeController.dispose();
    isTimerCounterCountDownActive.value = false;
    outSideCounter.value = true;
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _timeControllerOutSide.dispose();
    _timeController.dispose();

    super.dispose();
  }

  void onEndTimeOutSide() {
    outSideCounter.value = false;
    if (timerStatus.value) {
      Navigator.of(context).pop();
    }
    // log("the timer end ", name: 'timer');
    // isTimerCounterCountDownActive.value=false;
    // outSideCounter.value=true;
    // outSideEndTime = DateTime.now().millisecondsSinceEpoch + 1000 * outSideSecondsDuration;
    // _timeControllerOutSide = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        onTap: () => Navigator.of(context).pop(),
        titleText: 'الاسئلة',
        titleTextStyle: context.exTextTheme.headline3!
            .copyWith(color: context.exOnBackground),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.menu),
          onPressed: () {
            showAdaptiveDialog(
              builder: (context) => Dialog(
                child: ValueListenableBuilder(
                  valueListenable: isTimerCounterCountDownActive,
                  builder: (context, value, child) => Container(
                    width: 0.85.sw,
                    height: 200.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w)),
                    child: Stack(children: [
                      // Column(children: [
                      //   Row(
                      //     children: [
                      //       Text('تشغيل المؤقت'),
                      //       ValueListenableBuilder(
                      //         valueListenable: timerStatus,
                      //         builder: (context, counterStatus, child) =>
                      //             FlutterSwitch(
                      //           value: counterStatus,
                      //           activeColor: context.exPrimaryColor,
                      //           onToggle: (value) {
                      //             timerStatus.value = value;
                      //             debugPrint("value.toString()${value.toString()}");
                      //             if (value &&
                      //                 !isTimerCounterCountDownActive.value) {
                      //               debugPrint("lnbasdlnasd");
                      //               endTime =
                      //                   DateTime.now().millisecondsSinceEpoch +
                      //                       1000 * secondsDuration;
                      //               _timeController = CountdownTimerController(
                      //                   endTime: endTime, onEnd: onEnd);
                      //               isTimerCounterCountDownActive.value = true;
                      //               // timer = Timer.periodic(
                      //               //     const Duration(seconds: 1), (timer) {
                      //               //   if (timer.tick % 2 == 0) {
                      //               //     animatedOpacityCounterValue.value = true;
                      //               //   } else {
                      //               //     animatedOpacityCounterValue.value = false;
                      //               //   }
                      //               // });
                      //             } else {
                      //               outSideCounter.value = false;
                      //               isTimerCounterCountDownActive.value = false;
                      //             }
                      //             //  timerStatus.value=value;
                      //           },
                      //         ),
                      //       )
                      //     ],
                      //   )
                      // ]),
                      Positioned.fill(
                        child: ValueListenableBuilder(
                          valueListenable: isTimerCounterCountDownActive,
                          builder: (context, value, child) => value
                              ? Container(
                                  child: ValueListenableBuilder(
                                      valueListenable:
                                          animatedOpacityCounterValue,
                                      builder: (context, value, child) =>
                                          Center(
                                            child: CountdownTimer(
                                              onEnd: onEnd,
                                              controller: _timeController,
                                              widgetBuilder: (context, time) =>
                                                  Text(
                                                "${time!.sec}",
                                                style: context
                                                    .exTextTheme.headline3!
                                                    .copyWith(
                                                        color: context
                                                            .exOnBackground),
                                              ),
                                            ),
                                          )),
                                )
                              : Column(children: [
                                  10.h.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 30.w,
                                        height: 30.h,
                                      ),
                                      Text(
                                        'عرض الأسئلة مع الحل',
                                        style: context.exTextTheme.bodyText1!.copyWith(color: context.exOnBackground),
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                        height: 30.h,
                                      ),
                                      Checkbox(
//todo here you can show the questions with the answer

                                        value: false, onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                  5.h.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 30.h,
                                        height: 30.w,
                                      ),
                                      Text(
                                        'تشغيل المؤقت',
                                        style: context.exTextTheme.bodyText1!.copyWith(color: context.exOnBackground),
                                      ),
                                      SizedBox(
                                        width: 85.w,
                                        height: 30.h,
                                      ),
                                      ValueListenableBuilder(
                                        valueListenable: timerStatus,
                                        builder:
                                            (context, counterStatus, child) =>
                                                FlutterSwitch(
                                          width: 50.w,
                                          height: 20.h,
                                          value: counterStatus,
                                          activeColor: context.exPrimaryColor,
                                          onToggle: (value) {
                                            timerStatus.value = value;
                                            debugPrint(
                                                "value.toString()${value.toString()}");
                                            if (value &&
                                                !isTimerCounterCountDownActive
                                                    .value) {
                                              debugPrint("lnbasdlnasd");
                                              endTime = DateTime.now()
                                                      .millisecondsSinceEpoch +
                                                  1000 * secondsDuration;
                                              _timeController =
                                                  CountdownTimerController(
                                                      endTime: endTime,
                                                      onEnd: onEnd);
                                              isTimerCounterCountDownActive
                                                  .value = true;
                                              // timer = Timer.periodic(
                                              //     const Duration(seconds: 1), (timer) {
                                              //   if (timer.tick % 2 == 0) {
                                              //     animatedOpacityCounterValue.value = true;
                                              //   } else {
                                              //     animatedOpacityCounterValue.value = false;
                                              //   }
                                              // });
                                            } else {
                                              outSideCounter.value = false;
                                              isTimerCounterCountDownActive
                                                  .value = false;
                                            }
                                            //  timerStatus.value=value;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  5.h.verticalSpace,
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 30.h,
                                          height: 30.w,
                                        ),
                                        Text(
                                          'عرض عدد الأسئلة الصحيحة',
                                          style: context.exTextTheme.bodyText1!.copyWith(color: context.exOnBackground),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        Checkbox(
//todo here you can show the questions with the answer

                                          value: false,
                                          onChanged: (value) {},
                                        ),
                                      ])
                                ]),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              context: context,
            );
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          10.h.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'دورة 2018',
                style: context.exTextTheme.subtitle1!
                    .copyWith(color: context.exPrimaryColor),
              ),
              Text(
                'علوم',
                style: context.exTextTheme.headline3!
                    .copyWith(color: context.exOnBackground),
              ),
              ValueListenableBuilder(
                  valueListenable: outSideCounter,
                  builder: (context, value, child) {
                    return value
                        ? () {
                            outSideEndTime =
                                DateTime.now().millisecondsSinceEpoch +
                                    1000 * outSideSecondsDuration;
                            _timeControllerOutSide = CountdownTimerController(
                                endTime: outSideEndTime,
                                onEnd: onEndTimeOutSide);

                            debugPrint('activeOutSide');

                            return Container(
                              width: 50.w,
                              height: 50.h,
                              child: Center(
                                child: CountdownTimer(
                                  onEnd: () => onEndTimeOutSide,
                                  controller: _timeControllerOutSide,
                                  widgetBuilder: (context, time) =>
                                      Text('${time!.sec}'),
                                ),
                              ),
                            );
                          }()
                        : SizedBox(width: 50.w, height: 50.h);
                    return SizedBox.shrink();
                  }),
            ],
          ),
          10.h.verticalSpace,
          RichText(
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
              ])),
          // ValueListenableBuilder(valueListenable: expansionTile, builder:(context, value, child) =>        ,),

          Row(children: [
            Checkbox(
              value: open,
              onChanged: (value) {
                setState(() {
                  open = !open;
                });
              },
            ),
            Text(
              open ? 'إخفاء الأجوبة' : 'إظهار الأجوبة',
              style: context.exTextTheme.subtitle1!
                  .copyWith(color: context.exPrimaryColor),
            )
          ]),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return QuestionTileWidget(
                open: open,
              );
            },
            itemCount: 21,
          ))
        ],
      ).paddingHorizontal(10.w),
    );
  }
}
