import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../courses_questions_controller.dart';

class TitleOfQuestions extends StatefulWidget {
  int question_index;

  TitleOfQuestions({Key? key, required this.question_index}) : super(key: key);

  @override
  State<TitleOfQuestions> createState() => _TitleOfQuestionsState();
}

class _TitleOfQuestionsState extends State<TitleOfQuestions> {
  late CoursesQuestionsController controller;
  bool isExpanded = false;
  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final questionPreview = controller.questions[widget.question_index].text.length > 100
        ? controller.questions[widget.question_index].text.substring(0, 100) + '...'
        : controller.questions[widget.question_index].text;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupMenuButton(
          color: context.exOnPrimaryContainer,
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: Text('ابلاغ' , style: TextStyle(color: context.exPrimaryContainer)),
              value: 'report',
            ),
          ],
          onSelected: (value) {
            if (value == 'report') {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('ابلاغ' , style: TextStyle(color: context.exPrimaryContainer)),
                    content: TextFormField(
                      style: TextStyle(color: context.exPrimaryContainer),
                      decoration: InputDecoration(
                        labelText: 'ادخل ابلاغك',
                        labelStyle:  TextStyle(color: context.exPrimaryContainer)
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Send report logic here
                          Navigator.of(context).pop();
                        },
                        child: Text('ارسال للمراجعة' , style: TextStyle(color: context.exPrimaryContainer)),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: isExpanded? controller.questions[widget.question_index].text : questionPreview,
                  style: context.exTextTheme.titleMedium!.copyWith(
                    color: context.exOnBackground,
                  ),
                ),
              ),
              if (controller.questions[widget.question_index].text.length > 100)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(isExpanded ? 'عرض أقل' : 'عرض المزيد',style: TextStyle(fontSize: 15,color: context.exOnBackground,),),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}