import 'package:auto/core/data/repositories/read_all_models.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/shared/custom_widgets/media_view/media_widget/cache_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/data/models/local_json/all_models.dart';
import '../../wellcom_screen/not_widget.dart';
import '../courses_questions_controller.dart';
import 'answer_line_widget.dart';
import 'image_display_widget.dart';
import 'title_of_questions.dart';

class QuestionTileWidget extends StatefulWidget {
  final int questionIndex;
  final bool showSolutions;

  const QuestionTileWidget({
    Key? key,
    required this.questionIndex,
    required this.showSolutions,
  }) : super(key: key);

  @override
  State<QuestionTileWidget> createState() => _QuestionTileWidgetState();
}

class _QuestionTileWidgetState extends State<QuestionTileWidget> {
  late CoursesQuestionsController controller;
  int answerIndexCount = -1;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoursesQuestionsController>(builder: (controller) {
      if (controller.filteredQuestions.isEmpty) {
        return Container(); // Handle case where questions list is null or empty
      }

      // Ensure questionIndex is within valid range
      if (widget.questionIndex < 0 ||
          widget.questionIndex >= controller.filteredQuestions.length) {
        return Container(); // Return an empty container if index is invalid
      }

      final question = controller.filteredQuestions[widget.questionIndex];
      final questionId = question.id;

      if (question.answers == null || question.answers!.isEmpty) {
        return Container(); // Handle case where answers list is null or empty
      }
      return ShowCaseWidget(
        builder: (context) => Card(
          color: context.exOnPrimaryContainer,
          shadowColor: Colors.white,
          elevation: 20.0,
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05), // لون شفاف للخلفية
                      borderRadius: BorderRadius.circular(20), // حواف مستديرة
                      boxShadow: [
                        BoxShadow(
                          color: context.primaryColor.withOpacity(0.2), // ظل خفيف
                          blurRadius: 10, // نصف قطر التمويه
                          spreadRadius: 8, // مدى الانتشار
                          offset: Offset(0, 3), // إزاحة الظل للأسفل
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TitleOfQuestions(
                        question_index: widget.questionIndex,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.blue),
                      onPressed: () {
                        JsonReader.shareQuestion(context, questionId.toString());
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.blueAccent,),
              controller.hideAllAnswers.value
                  ? SizedBox()
                  : SizedBox(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: question.answers!.length,
                        itemBuilder: (context, index) {
                          final answer = question.answers![index];
                          if (answer == null) {
                            return Container(); // Handle null answers if any
                          }
                          return AnswerLine(
                            key: Key(answer.id.toString()),
                            answerIndex: index,
                            questionIndex: widget.questionIndex,
                            answer: answer,
                          );
                        },
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.questions[widget.questionIndex].image != null)
                    IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.grey),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ImageDisplayWidget(
                              imageUrl: controller.questions[widget.questionIndex].image,
                            );
                          },
                        );
                      },
                    ),

                  IconButton(
                    icon: Icon(
                      Icons.star,
                      color: controller.isFavorite(questionId)
                          ? Colors.yellow
                          : Colors.grey,
                    ),
                    onPressed: () {
                      controller.toggleFavorite(questionId);
                    },
                  ),
                  if (controller.questions[widget.questionIndex].explain !=
                      null)
                    IconButton(
                      icon: Icon(Icons.help, color: Colors.grey),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'شرح السؤال',
                                style: TextStyle(fontSize: 24),
                              ),
                              content: Text(controller
                                      .questions[widget.questionIndex]
                                      .explain ??
                                  'لا يوجد شرح لهذا السؤال.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('إغلاق'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  IconButton(
                    icon: Icon(Icons.folder, color: Colors.grey),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NoteDialogWidget(
                            questionId: question.id,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ]),
          ),
        ),
      );
    });
  }
}
