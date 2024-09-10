import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/models/favorite_note_models.dart';
import '../../../../core/data/network/api_client.dart';
import '../../../../core/data/repositories/fav_not_repo.dart';
import '../../../../core/data/repositories/read_all_models.dart';
import '../courses_questions_controller.dart';

class TitleOfQuestions extends StatefulWidget {
  int question_index;
  String question_id;

  TitleOfQuestions(
      {Key? key, required this.question_index, required this.question_id})
      : super(key: key);

  @override
  State<TitleOfQuestions> createState() => _TitleOfQuestionsState();
}

class _TitleOfQuestionsState extends State<TitleOfQuestions> {
  late CoursesQuestionsController controller;
  TextEditingController complaintsController = TextEditingController();

  bool isExpanded = false;
  late ApiClient apiClient;

  late FavoritesRepository favoritesRepository;

  @override
  void initState() {
    controller = Get.put(CoursesQuestionsController());

    apiClient = ApiClient(baseUrl: 'https://auto-sy.com/api');
    favoritesRepository = FavoritesRepository(apiClient: apiClient);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final questionPreview =
        controller.questions[widget.question_index].text.length > 200
            ? controller.questions[widget.question_index].text
                    .substring(0, 200) +
                '...'
            : controller.questions[widget.question_index].text;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PopupMenuButton(
              color: context.exOnPrimaryContainer,
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: Text('ابلاغ',
                      style: TextStyle(color: context.exPrimaryContainer)),
                  value: 'report',
                ),
              ],
              onSelected: (value) {
                if (value == 'report') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('ابلاغ',
                            style:
                                TextStyle(color: context.exPrimaryContainer)),
                        content: TextFormField(
                          controller: complaintsController,
                          style: TextStyle(color: context.exPrimaryContainer),
                          decoration: InputDecoration(
                              labelText: 'ادخل ابلاغك',
                              labelStyle:
                                  TextStyle(color: context.exPrimaryContainer)),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String myCodeId =
                                  prefs.getString('code_id') ?? "no_code";
                              ComplaintsRequest request = ComplaintsRequest(
                                  codeId: myCodeId,
                                  text: complaintsController.text,
                                  questionId: controller
                                      .questions[widget.question_index].id
                                      .toString());
                              // Send report logic here
                              favoritesRepository.addComplaints(request);
                              complaintsController.clear();
                              Navigator.of(context).pop();
                            },
                            child: Text('ارسال للمراجعة',
                                style: TextStyle(
                                    color: context.exPrimaryContainer)),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.share, color: Colors.blue),
              onPressed: () {
                JsonReader.shareQuestion(context, widget.question_id);
              },
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            text: isExpanded
                ? controller.questions[widget.question_index].text
                : questionPreview,
            style: context.exTextTheme.titleMedium!.copyWith(
              color: context.exOnBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (controller.questions[widget.question_index].text.length > 200)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? 'عرض أقل' : 'عرض المزيد',
                  style: TextStyle(
                    fontSize: 15,
                    color: context.exOnBackground,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
