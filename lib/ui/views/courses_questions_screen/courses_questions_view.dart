import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../shared/colors.dart';
import 'courses_questions_controller.dart';
import 'widgets/quesion_tile_widget.dart';
import 'widgets/timer_litsner.dart';

class CoursesQuestionsView extends StatefulWidget {
  final int id_course_bank_lesson_unite;
  final String type;
  final String subjectName;
  final String coursName;
  final int? idLESSON;
  final int? idPart;
  final int? idUnit;
  final int? favoriteSubject;
  final bool? isLesson;
  final bool? isFavorite ;
// تغيير التسمية إلى camelCase

  CoursesQuestionsView(
      {Key? key,
      required this.id_course_bank_lesson_unite,
      required this.type,
      required this.subjectName,
      required this.coursName,
      this.idLESSON,
      this.idPart,
      this.idUnit,
        this.favoriteSubject,
        this.isFavorite,
      this.isLesson})
      : super(key: key);

  @override
  State<CoursesQuestionsView> createState() => _CoursesQuestionsViewState();
}

class _CoursesQuestionsViewState extends State<CoursesQuestionsView> {
  late CoursesQuestionsController controller;
  late TextEditingController searchController;
  bool isisSearchActive = false;

  void readFile() {
    if (widget.isLesson != null) {
      controller.readfileForLesson(widget.idLESSON!, widget.type);
    } else if (widget.idPart != null) {
      controller.readfileForPart(widget.idPart!, widget.type);
    }  else if (widget.idUnit != null) {
      controller.readfileForUnit(widget.idUnit!, widget.type);
    } else if (widget.isFavorite !=null) {
      controller.readfileForFavorite();
    }else if (widget.favoriteSubject != null) {
      controller.readfileForFavoriteSubject(widget.favoriteSubject!);
    } else{
      controller.readfileForCoursOrBank(
          widget.id_course_bank_lesson_unite, widget.type);
    }
  }

// here first QuestionsView 887744556633
  @override
  void initState() {
    super.initState();
    controller = Get.put(CoursesQuestionsController());
    searchController = TextEditingController();
    print("cid_course_bank_lesson_unite ${widget.id_course_bank_lesson_unite}");
    readFile();
    controller.initializeExpandedQuestions();
    // Listen to changes in search text field
    searchController.addListener(onSearchTextChanged);
  }

  @override
  void dispose() {
    Get.delete<CoursesQuestionsController>();
    searchController.dispose();
    super.dispose();
  }

  void onSearchTextChanged() {
    controller.searchQuestions(searchController.text);
  }

  void _resetAnswers() {
    controller.resetAllStates();
  }

  void _showSolutions() {
    controller.highlightCorrectAnswers();
  }

  void _toggleFavoriteQuestions() {
    controller.showFavorites.value = !controller.showFavorites.value;
  }

  void _toggleSearchBar() {
    controller.isSearchActive.value = !controller.isSearchActive.value;
    if (!controller.isSearchActive.value) {
      // Clear search text and reset to show all questions
      searchController.clear(); // Clear search text field
      controller.clearSearch(); // Clear filtered search results
      // Call readfile again to reset to show all questions
      controller.readfileForCoursOrBank(
          widget.id_course_bank_lesson_unite, widget.type);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: (context) {
        return Scaffold(
          backgroundColor: context.exOnPrimaryContainer,
          appBar: AppBar(
            backgroundColor: context.exOnPrimaryContainer,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
            title: Center(
              child: Text(
                'الأسئلة',
                style: context.exTextTheme.titleMedium!
                    .copyWith(color: context.exOnBackground),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: _toggleSearchBar,
              ),
             if(widget.favoriteSubject == null) Showcase(
                key: controller.favQuestion,
                description: "عرض الاسئلة المفضلة فقط ",
                child: Obx(
                  () => IconButton(
                    icon: Icon(
                      controller.showFavorites.value
                          ? Icons.star
                          : Icons.star_border,
                      color: controller.showFavorites.value
                          ? Colors.yellow[800]
                          : Colors.yellow[800],
                    ),
                    onPressed: _toggleFavoriteQuestions,
                  ),
                ),
              ),
            ],
          ),
          body: Builder(
            builder: (context) {
              controller.showcaseController(context, false);
              return GetBuilder<CoursesQuestionsController>(
                init: controller,
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return controller.isSearchActive.value
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: TextField(
                                  controller: searchController,
                                  onChanged: (value) =>
                                      controller.searchQuestions(value),
                                  decoration: InputDecoration(
                                    hintText: 'ابحث عن سؤال',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        _toggleSearchBar();
                                        searchController.clear();
                                        controller.clearSearch();
                                        controller.readfileForCoursOrBank(
                                            widget.id_course_bank_lesson_unite,
                                            widget
                                                .type); // Optionally clear search results
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      }),
                      30.h.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          2.horizontalSpace,
                          Text(
                            widget.subjectName,
                            style: context.exTextTheme.titleMedium!
                                .copyWith(color: context.exOnBackground),
                          ),
                          Text(
                            widget.coursName,
                            key: controller.floatingButtonKey,
                            style: context.exTextTheme.titleMedium!
                                .copyWith(color: context.exOnBackground),
                          ),
                          RichText(
                            key: controller.editButtonKey,
                            text: TextSpan(
                              text: 'عدد الأسئلة : ',
                              style: context.exTextTheme.titleMedium!
                                  .copyWith(color: context.exOnBackground),
                              children: [
                                TextSpan(
                                  text: controller.questions.length.toString(),
                                  style: context.exTextTheme.titleMedium!
                                      .copyWith(color: context.exOnBackground),
                                ),
                              ],
                            ),
                          ),
                          2.horizontalSpace,
                        ],
                      ),
                      20.h.verticalSpace,
                      Row(
                        children: [
                          Showcase(
                            key: controller.timerKey,
                            description:
                                'اضغط على المؤقت لبدء الإجابة على الأسئلة',
                            child: TimerListener(
                              onTimeEnd: controller.calculateResults,
                            ),
                          ),
                          Spacer(),
                          Showcase(
                            key: controller.correctKey,
                            description: 'عدد الأسئلة الصحيحة',
                            child: Obx(
                              () => Container(
                                width: 40.w,
                                height: 40.h,
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    '${controller.correctAnswers.value}',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Showcase(
                            key: controller.wrongKey,
                            description: "عدد الأسئلة الخاطئة",
                            child: Obx(
                              () => Container(
                                width: 40.w,
                                height: 40.h,
                                color: Colors.red,
                                child: Center(
                                  child: Text(
                                    '${controller.wrongAnswers.value}',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Showcase(
                            key: controller.answerWithoutSoution,
                            description: "عدد الاسئلة غير المجاوب عليها",
                            child: Obx(
                              () => Container(
                                width: 40.w,
                                height: 40.h,
                                color: Colors.grey,
                                child: Center(
                                  child: Text(
                                    '${controller.countOfDidnotAnswers.value}',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Showcase(
                            key: controller.submitKey,
                            description:
                                "اضغط هنا لمعرفة الإجابات الصحيحة والخاطئة",
                            child: IconButton(
                              onPressed: controller.calculateResults,
                              icon: Icon(Icons.check,
                                  size: 30, color: Colors.green),
                            ),
                          ),
                          Showcase(
                            description: "لاخفاء الاجوبة",
                            key: controller.hideAnswer,
                            child: IconButton(
                              onPressed: () {
                                controller.toggleHideQuestions();
                              },
                              icon: Icon(Icons.hide_source,
                                  size: 30, color: Colors.green),
                            ),
                          ),
                          Spacer(),
                          10.w.horizontalSpace,
                          Showcase(
                            key: controller.resetKey,
                            description: "البدء من جديد بحل الأسئلة ",
                            child: IconButton(
                              onPressed: _resetAnswers,
                              icon: Icon(Icons.refresh,
                                  color: Colors.orange, size: 30.sp),
                            ),
                          ),
                          10.w.horizontalSpace,
                          Showcase(
                            key: controller.solution,
                            description: "شرح الايقونات",
                            child: IconButton(
                              onPressed: () {
                                controller.showcaseController(context, true);
                              },
                              icon: Icon(Icons.lightbulb,
                                  color: Colors.yellow[800], size: 30.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Obx(
                        () => controller.isLoading.value
                            ? SpinKitThreeBounce(
                                color: AppColors.blueB4,
                                size: 50.0,
                              )
                            : Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, questionIndex) {
                                    return QuestionTileWidget(
                                      questionIndex: questionIndex,
                                      showSolutions:
                                          controller.showSolutions.value,
                                    );
                                  },
                                  itemCount:
                                      controller.filteredQuestions.length,
                                ),
                              ),
                      ),
                    ],
                  ).paddingHorizontal(10.w);
                },
              );
            },
          ),
        );
      },
    );
  }
}
