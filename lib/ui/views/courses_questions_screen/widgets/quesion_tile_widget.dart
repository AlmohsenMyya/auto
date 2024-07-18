import 'package:auto/core/data/repositories/read_all_models.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/shared/custom_widgets/media_view/media_widget/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/data/models/local_json/all_models.dart';
import '../../wellcom_screen/not_widget.dart';
import '../courses_questions_controller.dart';
import 'answer_line_widget.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TitleOfQuestions(
                      question_index: widget.questionIndex,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.blue),
                    onPressed: () {
                      JsonReader.shareQuestion(questionId.toString());
                    },
                  ),
                ],
              ),
              controller.hideAllAnswers.value
                  ? SizedBox()
                  : SizedBox(
                      height: 65 * question.answers!.length.toDouble(),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: question.answers!.length,
                        itemBuilder: (context, index) {
                          final answer = question.answers![index];
                          if (answer == null) {
                            return Container(); // Handle null answers if any
                          }
                          return AnswerLine(
                            key: Key(answer.id.toString()),
                            answerIndex: index,
                            // Ensure each AnswerLine has a unique key
                            questionIndex: widget.questionIndex,
                            answer: answer,
                          );
                        },
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.grey),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'صورة للسؤال',
                              style: TextStyle(fontSize: 24),
                            ),
                            content: controller.questions[widget.questionIndex]
                                        .image ==
                                    null
                                ? Text('لا يوجد صورة لهذا السؤال.')
                                : CachedNetworkImage(
                                    hash: '',
                                    url: controller
                                        .questions[widget.questionIndex].image!,
                                    width: 200,
                                    height: 200,
                                  ),
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
