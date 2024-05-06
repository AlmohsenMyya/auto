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
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:get/get.dart';

import '../../../core/services/base_controller.dart';

class CoursesQuestionsController extends BaseController {
  late int endTime = 1;
  ExpansionTileController expController = ExpansionTileController();
  late int outSideEndTime = 1;
  late CountdownTimerController timeController =
  CountdownTimerController(endTime: endTime);
  int secondsDuration = 4;
  int outSideSecondsDuration = 4;
  ValueNotifier<bool> timerStatus = ValueNotifier(false);
  ValueNotifier<bool> isTimerCounterCountDownActive = ValueNotifier(false);
  ValueNotifier<bool> animatedOpacityCounterValue = ValueNotifier(false);
  ValueNotifier<bool> outSideCounter = ValueNotifier(false);
  ValueNotifier<bool> expansionTile = ValueNotifier(false);
  RxBool open = true.obs;
  Timer? timer;
  final GlobalKey floatingButtonKey = GlobalKey();
  final GlobalKey editButtonKey = GlobalKey();
  final GlobalKey settingsButtonKey = GlobalKey();

  late CountdownTimerController timeControllerOutSide =
  CountdownTimerController(endTime: endTime, onEnd: onEnd);

  void onEnd() {
    log("the timer end ", name: 'timer');

    timeControllerOutSide.dispose();
    timeController.dispose();
    isTimerCounterCountDownActive.value = false;
    outSideCounter.value = true;
    Get.back();
  }

  void secureWindow() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void onInit() {
    super.onInit();
    secureWindow();
    _createTutorial();
  }

  @override
  void onClose() {
    timeControllerOutSide.dispose();
    timeController.dispose();
    super.onClose();
  }

  void onEndTimeOutSide() {
    outSideCounter.value = false;
    if (timerStatus.value) {
      Get.back();
    }
  }

  Future<void> _createTutorial() async {
    final targets = [
      TargetFocus(
        identify: 'floatingButton',
        keyTarget: floatingButtonKey,
        alignSkip: Alignment.topCenter,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) => Text(
              'Use this button to add new elements to the list',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'editButton',
        keyTarget: editButtonKey,
        alignSkip: Alignment.bottomCenter,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Text(
                'You can edit----- the entries by pressing on the edit button',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'settingsButton',
        keyTarget: settingsButtonKey,
        alignSkip: Alignment.bottomCenter,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(
              'Configure the app in the settings screen',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    ];

    final tutorial = TutorialCoachMark(
      targets: targets,
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      tutorial.show(context: Get.context!);
    });
  }
}