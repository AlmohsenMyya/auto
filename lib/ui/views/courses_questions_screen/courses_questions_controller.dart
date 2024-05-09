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
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';
import '../../../core/services/base_controller.dart';

class CoursesQuestionsController extends BaseController {
  late RxInt endTime = 1.obs;
  ExpansionTileController expController = ExpansionTileController();
  late RxInt outSideEndTime = 1.obs;
  late CountdownTimerController timeController =
      CountdownTimerController(endTime: endTime.value);
  RxInt secondsDuration = 4.obs;
  RxInt outSideSecondsDuration = 4.obs;
  ValueNotifier<bool> timerStatus = ValueNotifier(false);
  ValueNotifier<bool> isTimerCounterCountDownActive = ValueNotifier(false);
  ValueNotifier<bool> animatedOpacityCounterValue = ValueNotifier(false);
  ValueNotifier<bool> outSideCounter = ValueNotifier(false);
  ValueNotifier<bool> expansionTile = ValueNotifier(false);
  RxBool openExpand = true.obs;
  RxBool answerTheQuestion = false.obs;
  Timer? timer;
  final GlobalKey floatingButtonKey = GlobalKey();
  final GlobalKey editButtonKey = GlobalKey();
  final GlobalKey settingsButtonKey = GlobalKey();
  RxBool isTimerActive = true.obs;
  Timer? mohsen_timer;
  RxInt countdown = 3.obs;
  late CountdownTimerController timeControllerOutSide =
      CountdownTimerController(endTime: endTime.value, onEnd: onEnd);
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;
  RxBool isChoosing = false.obs;

  final _expandedQuestions = <int, bool>{}.obs;

  void initializeExpandedQuestions() {
    for (int i = 0 ; i>150 ; i++) {
      _expandedQuestions[i] = false;
    }
  }
  bool isExpanded(int questionIndex) {
    return _expandedQuestions[questionIndex] ?? false;
  }

  void toggleExpand(int questionIndex) {
    _expandedQuestions[questionIndex] =
        !(_expandedQuestions[questionIndex] ?? false);
  }

  // void toggleExpandAll() {
  //   final allExpanded = _expandedQuestions.values.every((value) => value);
  //   _expandedQuestions.forEach((index, value) {
  //     _expandedQuestions[index] = !allExpanded;
  //   });
  // }
  void stopExpandAll() {
    openExpand.value = false;
    final allExpanded = _expandedQuestions.values.every((value) => value);
    _expandedQuestions.forEach((index, value) {
      _expandedQuestions[index] = false;
    });
  }
  void startExpandAll() {
    openExpand.value = true;
    final allExpanded = _expandedQuestions.values.every((value) => value);
    _expandedQuestions.forEach((index, value) {
      _expandedQuestions[index] = true;
    });
  }
  late List<Question> questions;
  Map<int, RxInt> selectedAnswers = {}; // Holds the selected answer ID

  void selectAnswer(int questionId, int answerId) {
    isChoosing.value = true;
    if (!selectedAnswers.containsKey(questionId)) {
      selectedAnswers[questionId] = RxInt(-1);
    }
    selectedAnswers[questionId]!.value = answerId;
    isChoosing.value = false;
  }

  int getSelectedAnswer(int questionId) {
    if (selectedAnswers.containsKey(questionId)) {
      return selectedAnswers[questionId]!.value;
    }
    return -1;
  }

  void readfile(int course_id) async {
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonFromAssets('assets/data.json');
    questions = JsonReader.extractQuestionsByCourseId(jsonfile, course_id);
    print("nlkmlnkl $course_id ${questions.length}");
    isLoading.value = false;
  }

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
    // _createTutorial();
  }

  void startTimer() {
    mohsen_timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
      } else {
        mohsen_timer?.cancel();

        isTimerActive = false.obs;
        countdown = 3.obs;
      }
    });
  }

  @override
  void onClose() {
    mohsen_timer?.cancel();
    super.dispose();

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
}
//
// Future<void> _createTutorial() async {
//   final targets = [
//     TargetFocus(
//       identify: 'floatingButton',
//       keyTarget: floatingButtonKey,
//       alignSkip: Alignment.topCenter,
//       contents: [
//         TargetContent(
//           align: ContentAlign.top,
//           builder: (context, controller) => Text(
//             'Use this button to add new elements to the list',
//             style: Theme.of(context)
//                 .textTheme
//                 .titleLarge
//                 ?.copyWith(color: Colors.white),
//           ),
//         ),
//       ],
//     ),
//     TargetFocus(
//       identify: 'editButton',
//       keyTarget: editButtonKey,
//       alignSkip: Alignment.bottomCenter,
//       contents: [
//         TargetContent(
//           align: ContentAlign.bottom,
//           builder: (context, controller) => Padding(
//             padding: const EdgeInsets.only(top: 100.0),
//             child: Text(
//               'You can edit----- the entries by pressing on the edit button',
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge
//                   ?.copyWith(color: Colors.white),
//             ),
//           ),
//         ),
//       ],
//     ),
//     TargetFocus(
//       identify: 'settingsButton',
//       keyTarget: settingsButtonKey,
//       alignSkip: Alignment.bottomCenter,
//       contents: [
//         TargetContent(
//           align: ContentAlign.bottom,
//           builder: (context, controller) => Text(
//             'Configure the app in the settings screen',
//             style: Theme.of(context)
//                 .textTheme
//                 .titleLarge
//                 ?.copyWith(color: Colors.white),
//           ),
//         ),
//       ],
//     ),
//   ];
//
//   final tutorial = TutorialCoachMark(
//     targets: targets,
//   );
//
//   Future.delayed(const Duration(milliseconds: 500), () {
//     tutorial.show(context: Get.context!);
//   });
// }
