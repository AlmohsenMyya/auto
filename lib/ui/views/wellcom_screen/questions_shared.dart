import 'package:auto2/core/data/models/local_json/all_models.dart';
import 'package:auto2/core/utils/extension/context_extensions.dart';
import 'package:auto2/ui/views/courses_questions_screen/courses_questions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/data/repositories/read_all_models.dart';
import '../courses_questions_screen/widgets/answer_line_widget.dart';
import '../courses_questions_screen/widgets/image_display_widget.dart';

class SingleQuestionPage extends StatefulWidget {
  final Question question;

  const SingleQuestionPage({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  State<SingleQuestionPage> createState() => _SingleQuestionPageState();
}

class _SingleQuestionPageState extends State<SingleQuestionPage> {
  late CoursesQuestionsController controller;
  int selected_answer = -1;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.question.answers == null || widget.question.answers!.isEmpty) {
      return Container(); // Handle case where answers list is null or empty
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('عرض السؤال'),
      ),
      body: Card(
        color: context.exOnPrimaryContainer,
        shadowColor: Colors.white,
        elevation: 20.0,
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.question.text,
                        // Assuming `title` is a property of `QuestionModel`
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.blue),
                      onPressed: () {
                        JsonReader.shareQuestion(context , widget.question.id.toString());
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.question.answers!.length,
                    itemBuilder: (context, index) {
                      final answer = widget.question.answers![index];
                      bool isCorrectAnswer = answer!.isCorrect == 1;
                      // Track if the answer is selected

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected_answer = index;
                            print("$isCorrectAnswer $selected_answer");
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              color: selected_answer == index ? isCorrectAnswer
                                  ? Colors.green
                                  : Colors.red
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 12.0),
                                child: Text(
                                  answer.text,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),);
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
                                  'صورة للسؤال', style: TextStyle(fontSize: 24)),
                              content: widget.question.image == null
                                  ? Text('لا يوجد صورة لهذا السؤال.')
                                  : ImageDisplayWidget(
                                imageUrl: widget.question.image,
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
                      icon: Icon(Icons.star, color: Colors.grey),
                      onPressed: () {
                        // Handle favorite action
                      },
                    ),
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
                              content: SingleChildScrollView(
                                child: Text(
                                  widget.question.explain ?? 'لا يوجد شرح لهذا السؤال.',
                                ),
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
                            ;
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
                              title: Text(
                                  'إرسال ملاحظة', style: TextStyle(fontSize: 24)),
                              content: TextField(
                                controller: noteController,
                                decoration: InputDecoration(
                                    hintText: "أدخل ملاحظتك هنا"),
                                maxLines: 3,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('إرسال'),
                                  onPressed: () {
                                    print(noteController
                                        .text); // Replace with your logic
                                    Navigator.of(context).pop();
                                  },
                                ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _getQuestionTextWithAnswers(Question question) {
    if (question.answers == null || question.answers!.isEmpty) {
      return null;
    }
    final buffer = StringBuffer();
    buffer.writeln(question.text);
    for (var answer in question.answers!) {
      buffer.writeln('- ${answer!.text}');
    }
    return buffer.toString();
  }
}
