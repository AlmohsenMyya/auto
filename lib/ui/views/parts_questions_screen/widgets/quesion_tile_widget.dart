import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/views/parts_questions_screen/parts_questions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showcaseview/showcaseview.dart';


import 'answer_line_widget.dart';
import 'title_of_questions.dart';

class PartsQuestionTileWidget extends StatefulWidget {
  final int questionIndex;
  final bool showResults;

  const PartsQuestionTileWidget({
    Key? key,
    required this.questionIndex,
    required this.showResults,
  }) : super(key: key);

  @override
  State<PartsQuestionTileWidget> createState() => _PartsQuestionTileWidgetState();
}

class _PartsQuestionTileWidgetState extends State<PartsQuestionTileWidget> {
  late UnitsQuestionsController controller;

  @override
  void initState() {
    controller = Get.put(UnitsQuestionsController());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnitsQuestionsController>(builder: (controller) {
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
          shadowColor:Colors.white,
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
                      final questionTextWithAnswers =
                      controller.getQuestionTextWithAnswersById(questionId);
                      if (questionTextWithAnswers != null) {
                        Share.share(
                            'Check out this question: \n$questionTextWithAnswers');
                      } else {
                        // Handle case where questionTextWithAnswers is null
                        // Maybe show a snackbar or handle it in another way
                      }
                    },
                  ),
                ],
              ),
              // Map answers with null check on each answer
              ...(question.answers!.map((answer) {
                if (answer == null)
                  return Container(); // Handle null answers if any
                return PartsAnswerLine(
                  key: Key(answer.id.toString()),
                  // Ensure each AnswerLine has a unique key
                  questionId: questionId,
                  answer: answer,
                  showResults: widget.showResults,
                );
              }).toList()),
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
                            title: Text('صورة للسؤال',style: TextStyle(fontSize: 24),),
                            content: controller.questions[widget.questionIndex].image == null
                                ? Text('لا يوجد صورة لهذا السؤال.')
                                : Image.asset(controller.questions[widget.questionIndex].image!),
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
                  IconButton(
                    icon: Icon(Icons.help, color: Colors.grey),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('شرح السؤال',style: TextStyle(fontSize: 24),),
                            content: Text(controller
                                .questions[widget.questionIndex].explain ??
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
                      TextEditingController noteController = TextEditingController();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('إرسال ملاحظة',style: TextStyle(fontSize: 24),),
                            content: TextField(
                              controller: noteController,
                              decoration: InputDecoration(hintText: "أدخل ملاحظتك هنا"),
                              maxLines: 3,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('إرسال'),
                                onPressed: () {

                                  print(noteController.text); // Replace with your logic
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('إغلاق',),
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
                ],
              ),
            ]),
          ),
        ),
      );
    });
  }
}
