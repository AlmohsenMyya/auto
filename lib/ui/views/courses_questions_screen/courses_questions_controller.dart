import 'dart:async';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../core/data/models/favorite_note_models.dart';
import '../../../core/data/models/local_json/all_models.dart';
import '../../../core/data/network/api_client.dart';
import '../../../core/data/repositories/fav_not_repo.dart';
import '../../../core/data/repositories/read_all_models.dart';
import '../../../core/services/base_controller.dart';

class CoursesQuestionsController extends BaseController {
  late ApiClient apiClient;

  late FavoritesRepository favoritesRepository;
  late String myCodeId;

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
  RxBool showResults = false.obs;
  Map<int, Map<int, Color>> answers_color = {};
  RxBool hideAllAnswers = false.obs;
  RxBool showAllFavorite = false.obs;

  final GlobalKey floatingButtonKey = GlobalKey();
  final GlobalKey editButtonKey = GlobalKey();
  final GlobalKey settingsButtonKey = GlobalKey();
  RxBool isTimerActive = false.obs;

  RxInt countdown = 10.obs;
  late CountdownTimerController timeControllerOutSide =
      CountdownTimerController(endTime: endTime.value, onEnd: onEnd);
  late Map<String, dynamic> jsonfile;
  RxBool isLoading = true.obs;
  RxBool isChoosing = false.obs;
  RxInt correctAnswers = 0.obs;
  RxInt wrongAnswers = 0.obs;
  RxInt countOfDidnotAnswers = 0.obs;
  bool showcaseCompleted = false;
  final GlobalKey timerKey = GlobalKey();
  final GlobalKey submitKey = GlobalKey();
  final GlobalKey starKey = GlobalKey();
  final GlobalKey correctKey = GlobalKey();
  final GlobalKey wrongKey = GlobalKey();
  final GlobalKey resetKey = GlobalKey();
  final GlobalKey hideAnswer = GlobalKey();
  final GlobalKey answerWithoutSoution = GlobalKey();
  final GlobalKey solution = GlobalKey();
  final GlobalKey favQuestion = GlobalKey();
  RxBool showFavorites = false.obs;
  RxBool showRowngs = false.obs;

  RxBool showSolutions = false.obs;
  RxList<Question> filteredQuestionsSearch = <Question>[].obs;
  RxBool isSearchActive = false.obs;

  late TextEditingController searchController;

  late CountdownTimerController countdownTimerController;
  Map<int, RxInt> selectedAnswers = {};
  late List<Question> questions = <Question>[].obs;
  late List<Question> mohsen_questions = <Question>[];
  final _expandedQuestions = <int, bool>{}.obs;

  RxList<int> favoriteQuestions = RxList<int>();
  RxList<int> rowngQuestions = RxList<int>();
  Timer? timer;
  int elapsedSeconds = 0;
  bool isRunning = false;
  Rx<String> myformatTime = "00:00".obs;
  final AudioPlayer audioPlayer = AudioPlayer();

  void initializeExpandedQuestions() {
    for (int i = 0; i < 150; i++) {
      _expandedQuestions[i] = false;
    }
  }

  bool isExpanded(int questionIndex) {
    return _expandedQuestions[questionIndex] ?? false;
  }

  void toggleHideQuestions() {
    hideAllAnswers.value = !hideAllAnswers.value;
    Get.closeAllSnackbars();
    if(hideAllAnswers.value){
      // إظهار رسالة خطأ
      Get.snackbar(
          'تم اخفاء كل الاجوبة !!',
          ' ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2)
      );
    }else{
      Get.snackbar(
          'تم اظهار كل الاجوبة !!',
          ' ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: Duration(seconds: 2)
      );
    }
    update();
  }

  void toggleExpand(int questionIndex) {
    _expandedQuestions[questionIndex] =
        !(_expandedQuestions[questionIndex] ?? false);
  }

  void toggleAnswerVisibility() {
    answerTheQuestion.value = !answerTheQuestion.value;
  }

  // تحقق من ما إذا كان السؤال مفضل
  bool isFavorite(int questionId) {
    return favoriteQuestions.contains(questionId);
  }

  void showcaseController(BuildContext context, bool reShowIt) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? showcaseCompleted = prefs.getBool('showcaseCompleted1');
      print("$showcaseCompleted sggg");
      if (showcaseCompleted == null || reShowIt) {
        ShowCaseWidget.of(context).startShowCase([
          timerKey,
          submitKey,
          hideAnswer,
          correctKey,
          wrongKey,
          answerWithoutSoution,
          resetKey,
          solution,
          favQuestion
        ]);

        await prefs.setBool('showcaseCompleted1', true);
      }
    });
  }

  // تغيير حالة التفضيل للسؤال
  void toggleFavorite(int questionId) {
    if (favoriteQuestions.contains(questionId)) {
      favoriteQuestions.remove(questionId);
       favoritesRepository.removeFavorite(myCodeId, questionId.toString());
    } else {
      favoriteQuestions.add(questionId);
      favoritesRepository
          .addFavorite(FavoriteRequest(codeId: myCodeId, questionId: questionId.toString()));
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

  // تحقق مما إذا كانت الأسئلة تحتوي على كلمة البحث
  bool containsSearchWord(Question question, String searchWord) {
    if (question.text.toLowerCase().contains(searchWord.toLowerCase())) {
      return true;
    }
    for (final a in question.answers!) {
      if (a!.text.toLowerCase().contains(searchWord.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  List<Question> get filteredQuestions {
    if (isSearchActive.value && searchController.text.isNotEmpty) {
      return questions
          .where((q) => containsSearchWord(q, searchController.text))
          .toList();
    } else if (showFavorites.value) {
      return questions.where((q) => favoriteQuestions.contains(q.id)).toList();
    } else if (showRowngs.value) {
      return questions.where((q) => rowngQuestions.contains(q.id)).toList();
    } else if (showAllFavorite.value) {
      loadFavorites();
      return favoriteQuestions.value as List<Question>;
    } else {
      return questions;
    }
  }

  void toggleShowFavorites() {
    showFavorites.value = !showFavorites.value;
    update();
  }

  void toggleshowRowngs() {
    showRowngs.value = !showRowngs.value;
    update();
  }

  void highlightCorrectAnswers() {
    showSolutions.value = true;
    update();
  }

  void initializeAnswerColors() {
    for (var questionIndex = 0;
        questionIndex < questions.length;
        questionIndex++) {
      answers_color[questionIndex] = {};
      var question = questions[questionIndex];
      for (var answerIndex = 0;
          answerIndex < question.answers!.length;
          answerIndex++) {
        answers_color[questionIndex]![answerIndex] =
            Colors.grey.shade300.withOpacity(0.8);
      }
    }
    update();
  }

  void initMyCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myCodeId = prefs.getString('code_id') ?? "no_code";
  }

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient(baseUrl: 'https://auto-sy.com/api');
    favoritesRepository = FavoritesRepository(apiClient: apiClient);
    initMyCode();
    // تهيئة وإعدادات أخرى عندما يتم دخول الصفحة لأول مرة
    // secureWindow();
    searchController = TextEditingController();
    countdownTimerController = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 60, // 1 minute
    );
    // Initialize controllers
    timeController = CountdownTimerController(endTime: endTime.value);
    timeControllerOutSide =
        CountdownTimerController(endTime: endTime.value, onEnd: onEnd);

    // تحميل الأسئلة المفضلة عندما يتم دخول الصفحة
    loadFavorites();
    print("consoooooooool reseeeeeeeet 1");
    resetAllStates();
  }

  void resetQuestionState() {
    // إعادة تهيئة حالة التحكم بالأسئلة والجواب المحدد
    correctAnswers.value = 0;
    wrongAnswers.value = 0;
    countOfDidnotAnswers.value = questions.length;
    rowngQuestions.value = [];
    selectedAnswers.clear();
    initializeAnswerColors();
    showResults.value = false;
  }

  void resetAllStates() {
    print("reseeeeeeeetAlllllll");
    resetQuestionState();
    resetTimer();
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
      await Future.delayed(
          Duration(milliseconds: 50)); // Adjust the duration as needed
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

    for (var questionIndex = 0;
        questionIndex < questions.length;
        questionIndex++) {
      var question = questions[questionIndex];
      var selectedAnswerIndex = getSelectedAnswer(questionIndex);

      for (var answerIndex = 0;
          answerIndex < question.answers!.length;
          answerIndex++) {
        var answer = question.answers![answerIndex];
        if (answer!.isCorrect == 1) {
          answers_color[questionIndex]![answerIndex] = Colors.green;
          if (selectedAnswers[questionIndex] == answerIndex) {
            correctAnswers.value++;
          }
        } else {
          if (selectedAnswers[questionIndex] == answerIndex) {
            // Correct answer
            answers_color[questionIndex]![answerIndex] = Colors.redAccent;
            wrongAnswers.value++;
          }
        }
      }
    }

    showResults.value = true;
    update();
  }

  void selectAnswer(int questionIndex, int answerIndex) {
    final questionAnswers = answers_color[questionIndex];
    for (var index in questionAnswers!.keys) {
      questionAnswers[index] = Colors.grey.shade100.withOpacity(0.8);
    }

    if (questions[questionIndex].answers![answerIndex]!.isCorrect == 0) {
      answers_color[questionIndex]![answerIndex] = Colors.redAccent;
      if (!rowngQuestions.contains(questions[questionIndex].id)) {
        rowngQuestions.add(questions[questionIndex].id);
      }
    } else {
      answers_color[questionIndex]![answerIndex] = Colors.green;
      rowngQuestions.remove(questions[questionIndex].id);
    }
    print("rongqisdefjd $rowngQuestions");

    print("answer color after $answers_color");
    isChoosing.value = true;
    print(
        "answers_color[questionIndex]![answerIndex] ${answers_color[questionIndex]![answerIndex]}");

    // Check the validity of the question index
    if (questionIndex < 0 || questionIndex >= questions.length) {
      print('Invalid question index: $questionIndex');
      isChoosing.value = false;
      return;
    }

    var question = questions[questionIndex];

    // Check the validity of the answer index
    if (question.answers == null ||
        answerIndex < 0 ||
        answerIndex >= question.answers!.length) {
      print('Invalid answer index: $answerIndex');
      isChoosing.value = false;
      return;
    }

    // If there was a previous answer, update the counters based on its correctness
    if (selectedAnswers.containsKey(questionIndex)) {
      var previousAnswerIndex = selectedAnswers[questionIndex]!.value;
      if (previousAnswerIndex != -1) {
        bool wasCorrect =
            question.answers![previousAnswerIndex]?.isCorrect == 1;
        if (wasCorrect) {
          correctAnswers.value--;
        } else {
          wrongAnswers.value--;
        }
      }
    }

    // Set the new selected answer
    if (!selectedAnswers.containsKey(questionIndex)) {
      selectedAnswers[questionIndex] = RxInt(-1);
    }
    selectedAnswers[questionIndex]!.value = answerIndex;

    // Check the correctness of the new answer
    bool isCorrect = question.answers![answerIndex]?.isCorrect == 1;
    if (isCorrect) {
      correctAnswers.value++;
    } else {
      wrongAnswers.value++;
    }
    countOfDidnotAnswers.value =
        questions.length - (wrongAnswers.value + correctAnswers.value);
    isChoosing.value = false;
    update();
  }

  int? getSelectedAnswer(int questionId) {
    if (selectedAnswers.containsKey(questionId)) {
      return selectedAnswers[questionId]!.value;
    }
    return null;
  }

  void readfileForUnit(int unitId, String type) async {
    print("readfileForLesson  partId $unitId  type $type ");
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonData();
    // استخراج الأسئلة بناءً على النوع
    if (type == "دورة") {
      questions = JsonReader.extractQuestionsByUnitId(jsonfile, unitId, true);
    } else if (type == "بنك") {
      questions = JsonReader.extractQuestionsByUnitId(jsonfile, unitId, false);
    }
    // ترتيب الأسئلة حسب المعرف
    questions.sort((a, b) => a.id.compareTo(b.id));

    // تغيير ترتيب الإجابات بشكل عشوائي إذا كان الشرط question.order_changing يساوي 1
    if (questions.isNotEmpty && questions[0].order_changing == 1) {
      questions.forEach((question) {
        question.answers?.shuffle();
      });
    }

    initializeAnswerColors();
    countOfDidnotAnswers.value = questions.length;
    mohsen_questions.assignAll(questions);

    // تحديث حالة التحميل
    isLoading.value = false;
  }

  void readfileForFavoriteSubject(int favoriteSubjectId) async {
    print("readfileForFavoriteSubject  ");
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonData();
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteList = prefs.getStringList('favoriteQuestions');
    if (favoriteList != null) {
      questions = JsonReader.extractQuestionsByIdListAndSubjectID(
          favoriteList, favoriteSubjectId, jsonfile);
      print(
          "readfileForFavoriteSubject  favoriteQuestions: ${favoriteQuestions.length}");
    }
    isLoading.value = false;
    update();
    // ترتيب الأسئلة حسب المعرف
    questions.sort((a, b) => a.id.compareTo(b.id));

    // تغيير ترتيب الإجابات بشكل عشوائي إذا كان الشرط question.order_changing يساوي 1
    if (questions.isNotEmpty && questions[0].order_changing == 1) {
      questions.forEach((question) {
        question.answers?.shuffle();
      });
    }

    initializeAnswerColors();
    countOfDidnotAnswers.value = questions.length;
    mohsen_questions.assignAll(questions);

    // تحديث حالة التحميل
    isLoading.value = false;
  }

  void readfileForFavorite() async {
    print("readfileForFavorite  ");
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonData();
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteList = prefs.getStringList('favoriteQuestions');
    if (favoriteList != null) {
      questions = JsonReader.extractQuestionsByIdList(favoriteList, jsonfile);
      print("loadFavorites  favoriteQuestions: ${favoriteQuestions.length}");
    }
    isLoading.value = false;
    update();
    // ترتيب الأسئلة حسب المعرف
    questions.sort((a, b) => a.id.compareTo(b.id));

    // تغيير ترتيب الإجابات بشكل عشوائي إذا كان الشرط question.order_changing يساوي 1
    if (questions.isNotEmpty && questions[0].order_changing == 1) {
      questions.forEach((question) {
        question.answers?.shuffle();
      });
    }

    initializeAnswerColors();
    countOfDidnotAnswers.value = questions.length;
    mohsen_questions.assignAll(questions);

    // تحديث حالة التحميل
    isLoading.value = false;
  }

  void readfileForPart(int partId, String type) async {
    print("readfileForLesson  partId $partId  type $type ");
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonData();
    if (type == "دورة") {
      questions = JsonReader.extractQuestionsByPartId(jsonfile, partId, true);
    } else if (type == "بنك") {
      questions = JsonReader.extractQuestionsByPartId(jsonfile, partId, false);
    }
    // ترتيب الأسئلة حسب المعرف
    questions.sort((a, b) => a.id.compareTo(b.id));

    // تغيير ترتيب الإجابات بشكل عشوائي إذا كان الشرط question.order_changing يساوي 1
    if (questions.isNotEmpty && questions[0].order_changing == 1) {
      questions.forEach((question) {
        question.answers?.shuffle();
      });
    }

    initializeAnswerColors();
    countOfDidnotAnswers.value = questions.length;
    mohsen_questions.assignAll(questions);

    // تحديث حالة التحميل
    isLoading.value = false;
  }

  void readfileForLesson(int lessonId, String type) async {
    print("readfileForLesson  lessonid $lessonId  type $type ");
    isLoading.value = true;
    // TODO: implement onInit
    jsonfile = await JsonReader.loadJsonData();
    if (type == "دورة") {
      print("bankkssks ");
      questions =
          JsonReader.extractQuestionsByLessonId(jsonfile, lessonId, true);
      print(questions.length);
    }

    if (type == "بنك") {
      print("bankkssks ");
      questions =
          JsonReader.extractQuestionsByLessonId(jsonfile, lessonId, false);
      print(questions.length);
    }

    // ترتيب الأسئلة حسب المعرف
    questions.sort((a, b) => a.id.compareTo(b.id));

    // تغيير ترتيب الإجابات بشكل عشوائي إذا كان الشرط question.order_changing يساوي 1
    if (questions.isNotEmpty && questions[0].order_changing == 1) {
      questions.forEach((question) {
        question.answers?.shuffle();
      });
    }

    initializeAnswerColors();
    countOfDidnotAnswers.value = questions.length;
    mohsen_questions.assignAll(questions);

    // تحديث حالة التحميل
    isLoading.value = false;
  }

  void readfileForCoursOrBank(int course_id, String type) async {
    isLoading.value = true;
    // تحميل ملف JSON من الأصول
    jsonfile = await JsonReader.loadJsonData();
    // استخراج الأسئلة بناءً على النوع
    if (type == "دورة") {
      questions = JsonReader.extractQuestionsByCourseId(jsonfile, course_id);
    } else if (type == "بنك") {
      questions = JsonReader.extractQuestionsByBankId(jsonfile, course_id);
    }
    // ترتيب الأسئلة حسب المعرف
    questions.sort((a, b) => a.id.compareTo(b.id));

    // تغيير ترتيب الإجابات بشكل عشوائي إذا كان الشرط question.order_changing يساوي 1
    if (questions.isNotEmpty && questions[0].order_changing == 1) {
      questions.forEach((question) {
        question.answers?.shuffle();
      });
    }

    initializeAnswerColors();
    countOfDidnotAnswers.value = questions.length;
    mohsen_questions.assignAll(questions);

    // تحديث حالة التحميل
    isLoading.value = false;
  }

  void onEnd() {
    log("the timer end ", name: 'timer');

    timeControllerOutSide.dispose();
    timeController.dispose();
    isTimerCounterCountDownActive.value = false;
    outSideCounter.value = true;
    // تحديث showResults.value لعرض النتائج عند انتهاء التوقيت
    showResults.value = true;
    Get.back();
  }

  void searchQuestions(String query) {
    if (query.isEmpty) {
      // If search query is empty, show all questions
      filteredQuestions.assignAll(mohsen_questions);
    } else {
      print("${questions.length}-- ${filteredQuestions.length} -- value $query -- ${mohsen_questions.length}" );
      // Filter questions based on search query
      filteredQuestions.assignAll(mohsen_questions
          .where((question) => containsSearchWord(question, query))
          .toList());
    }
    update(); // Ensure to call the update method to update the view.
  }

  void clearSearch() {
    searchController.clear();
    filteredQuestions.assignAll(questions);
    update(); // Ensure to call the update method to update the view.
  }

  Stream<int> get timerStream =>
      Stream.periodic(Duration(seconds: 1), (count) => countdown.value);

  void onEndTimeOutSide() {
    outSideCounter.value = false;
    if (timerStatus.value) {
      Get.back();
    }
    // تحديث showResults.value لعدم عرض النتائج عند انتهاء التوقيت الخارجي
    showResults.value = false;
  }

  String getQuestionTextWithAnswersById(int questionId) {
    final question = questions.firstWhere((q) => q.id == questionId);
    if (question != null) {
      String questionText = question.text;
      String? answersText =
          question.answers?.map((answer) => answer?.text).join('\n');
      return '$questionText\n\n$answersText';
    } else {
      return 'Question not found';
    }
  }

  //

  // void secureWindow() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // }

  ///timer

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedSeconds++;
      myformatTime.value = formatTime(elapsedSeconds);
      update();
    });
  }

  void stopTimer() {
    timer?.cancel();
    update();
  }

  Future<void> playSound(String sound) async {
    await audioPlayer.play(AssetSource(sound));
    update();
  }

  void handleTap() {
    if (isRunning) {
      stopTimer();
      playSound('sounds/pause.mp3');
    } else {
      startTimer();
      playSound('sounds/start.mp3');
    }

    isRunning = !isRunning;
    update();
  }

  void resetTimer() {
    stopTimer();

    elapsedSeconds = 0;
    isRunning = false;
    myformatTime.value = formatTime(elapsedSeconds);
    update();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  ///
}
