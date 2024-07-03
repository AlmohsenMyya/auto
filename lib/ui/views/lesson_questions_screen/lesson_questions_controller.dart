import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/repositories/read_all_models.dart';
import '../../../core/services/base_controller.dart';

class LessonsQuestionsController extends BaseController {
  late RxInt endTime = 1.obs;
  ExpansionTileController expController = ExpansionTileController();
  late RxInt outSideEndTime = 1.obs;
  late CountdownTimerController timeController =
  CountdownTimerController(endTime: endTime.value);
  RxInt secondsDuration = 4.obs;
  RxInt outSideSecondsDuration = 4.obs;
  ValueNotifier<bool> timerStatus = ValueNotifier(true);
  ValueNotifier<bool> isTimerCounterCountDownActive = ValueNotifier(false);
  ValueNotifier<bool> animatedOpacityCounterValue = ValueNotifier(false);
  ValueNotifier<bool> outSideCounter = ValueNotifier(false);
  ValueNotifier<bool> expansionTile = ValueNotifier(false);
  RxBool openExpand = false.obs;
  RxBool answerTheQuestion = false.obs;
  Timer? timer;
  final GlobalKey floatingButtonKey = GlobalKey();
  final GlobalKey editButtonKey = GlobalKey();
  final GlobalKey settingsButtonKey = GlobalKey();
  RxBool isTimerActive = false.obs;
  RxBool showFavorites = false.obs;

  RxInt countdown = 10.obs;
  late CountdownTimerController timeControllerOutSide =
  CountdownTimerController(endTime: endTime.value, onEnd: onEnd);
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;
  RxBool isChoosing = false.obs;
  RxInt correctAnswers = 0.obs;
  RxInt wrongAnswers = 0.obs;
  var showResults = false.obs;
  bool showcaseCompleted = false;
  final GlobalKey timerKey = GlobalKey();
  final GlobalKey submitKey = GlobalKey();
  final GlobalKey starKey = GlobalKey();
  final GlobalKey correctKey = GlobalKey();
  final GlobalKey wrongKey= GlobalKey();
  final GlobalKey resetKey =GlobalKey();
  final GlobalKey solution= GlobalKey();
  final GlobalKey favQuestion= GlobalKey();
  RxBool showSolutions = false.obs;



  late CountdownTimerController countdownTimerController;
  Map<int, RxInt> selectedAnswers = {};
  late List<Question> questions = <Question>[].obs;

  final _expandedQuestions = <int, bool>{}.obs;

  // قائمة الأسئلة المفضلة
  RxList<int> favoriteQuestions = RxList<int>();

  void initializeExpandedQuestions() {
    for (int i = 0; i < 150; i++) {
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

  //new
  void toggleAnswerVisibility() {
    answerTheQuestion.value = !answerTheQuestion.value;
  }

  // تحقق من ما إذا كان السؤال مفضل
  bool isFavorite(int questionId) {
    return favoriteQuestions.contains(questionId);
  }

  void showcaseController(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? showcaseCompleted = prefs.getBool('showcaseCompleted1');
      print("$showcaseCompleted sggg");
      if (showcaseCompleted==null) {
        ShowCaseWidget.of(context).
        startShowCase([timerKey,submitKey,correctKey,wrongKey,resetKey,solution,favQuestion]);

        await prefs.setBool('showcaseCompleted1', true);
      }

    });
  }
  List<Question> get filteredQuestions {
    if (showFavorites.value) {
      return questions.where((q) => favoriteQuestions.contains(q.id)).toList();
    } else {
      return questions;
    }
  }
  void toggleShowFavorites() {
    showFavorites.value = !showFavorites.value;
    update();
  }
  // تغيير حالة التفضيل للسؤال
  void toggleFavorite(int questionId) {
    if (favoriteQuestions.contains(questionId)) {
      favoriteQuestions.remove(questionId);
    } else {
      favoriteQuestions.add(questionId);
    }
    saveFavorites();
    update();
  }

  // حفظ قائمة الأسئلة المفضلة في التخزين المحلي
  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favoriteQuestions',
        favoriteQuestions.map((id) => id.toString()).toList());
  }

  // تحميل قائمة الأسئلة المفضلة من التخزين المحلي
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteList = prefs.getStringList('favoriteQuestions');
    if (favoriteList != null) {
      favoriteQuestions.value =
          favoriteList.map((id) => int.parse(id)).toList();
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();


    // تهيئة وإعدادات أخرى عندما يتم دخول الصفحة لأول مرة
    secureWindow();
    countdownTimerController = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60, // 1 minute
    );
    // Initialize controllers
    timeController = CountdownTimerController(endTime: endTime.value);
    timeControllerOutSide =
        CountdownTimerController(endTime: endTime.value, onEnd: onEnd);

    // تحميل الأسئلة المفضلة عندما يتم دخول الصفحة
    loadFavorites();
    print("consoooooooool reseeeeeeeet");
    resetAllStates();
  }


  void resetQuestionState() {
    // إعادة تهيئة حالة التحكم بالأسئلة والجواب المحدد
    correctAnswers.value = 0;
    wrongAnswers.value = 0;
    selectedAnswers.clear();
    showResults.value = false;

    //initializeExpandedQuestions();
  }

  void resetTimerState() {
    isTimerActive.value = false;
    countdown.value = 30;
  }

  void resetAllStates() {
    print("reseeeeeeeetAlllllll");
    resetQuestionState();
    resetTimerState();
  }

  void stopExpandAll() {
    openExpand.value = false;
    _expandedQuestions.forEach((index, value) {
      _expandedQuestions[index] = false;
    });
  }

  Future<void> stopExpandAllGradually() async {
    openExpand.value = false;
    for (int i = 0; i < _expandedQuestions.length; i++) {
      _expandedQuestions[i] = false;
      await Future.delayed(Duration(milliseconds: 50)); // Adjust the duration as needed
    }
  }

  void startExpandAll() {
    openExpand.value = true;
    _expandedQuestions.forEach((index, value) {
      _expandedQuestions[index] = true;
    });
  }

  void calculateResults() {
    correctAnswers.value = 0;
    wrongAnswers.value = 0;

    for (var question in questions) {
      for (var answer in question.answers!) {
        if (answer!.isCorrect == 1) {
          if (answer.id == getSelectedAnswer(question.id)) {
            correctAnswers.value++;
          } else {
            wrongAnswers.value++;
          }
        }
      }
    }
    showResults.value = true; // تحديث قيمة showResults هنا
  }

  // Holds the selected answer ID
  void selectAnswer(int questionId, int answerId) {
    isChoosing.value = true;
    if (!selectedAnswers.containsKey(questionId)) {
      selectedAnswers[questionId] = RxInt(-1);
    }

    if (selectedAnswers[questionId]!.value != -1) {
      bool wasCorrect = questions[questionId].answers!.any((answer) =>
      answer?.id == selectedAnswers[questionId]!.value &&
          answer!.isCorrect == 1);
      if (wasCorrect) {
        correctAnswers.value--;
      } else {
        wrongAnswers.value--;
      }
    }

    selectedAnswers[questionId]!.value = answerId;

    // تحقق من صحة الإجابة الجديدة
    bool isCorrect = questions[questionId].answers!.any((answer) =>
    answer?.id == answerId && answer!.isCorrect == 1);
    if (isCorrect) {
      correctAnswers.value++;
    } else {
      wrongAnswers.value++;
    }

    isChoosing.value = false;
  }

  int getSelectedAnswer(int questionId) {
    if (selectedAnswers.containsKey(questionId)) {
      return selectedAnswers[questionId]!.value;
    }
    return -1;
  }

  void readfile(int lessonId) async {
    // print("bankkssks88888 ${type == "بنك"} ");
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonFromAssets('assets/data.json');
    questions = JsonReader.extractQuestionsByLessonId(jsonfile, lessonId);

    // if (type == "بنك") {
    //   print("bankkssks ");
    //   questions = JsonReader.extractQuestionsByBankId(jsonfile, part_id);
    //   print(questions.length);
    // }
    print("nlkmlnkl $lessonId ${questions.length}");
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

  void startTimer() {
    if (timer != null) timer!.cancel(); // إلغاء المؤقت السابق إذا كان موجودًا
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
      } else {
        timer.cancel();
        isTimerActive.value = false;
      }
    });
  }

  Stream<int> get timerStream =>
      Stream.periodic(Duration(seconds: 1), (count) => countdown.value);

  void onEndTimeOutSide() {
    outSideCounter.value = false;
    if (timerStatus.value) {
      Get.back();
    }
  }
  String getQuestionTextWithAnswersById(int questionId) {
    final question = questions.firstWhere((q) => q.id == questionId);
    if (question != null) {
      String questionText = question.text;
      String? answersText = question.answers?.map((answer) => answer?.text).join('\n');
      return '$questionText\n\n$answersText';
    } else {
      return 'Question not found';
    }
  }


  void secureWindow() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
}
