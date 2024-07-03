import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../courses_controller.dart';

class CoursesCardWidget extends StatefulWidget {
  final int index;

  CoursesCardWidget({super.key, required this.index});

  @override
  State<CoursesCardWidget> createState() => _CoursesCardWidgetState();
}

class _CoursesCardWidgetState extends State<CoursesCardWidget> {
  late CoursesController controller;

  @override
  void initState() {
    controller = Get.put(CoursesController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: context.exOnPrimaryContainer,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    15.h.verticalSpace,
                    Text(
                      controller.courses[widget.index].name,
                      textDirection: TextDirection.ltr,
                      style: context.exTextTheme.titleMedium!
                          .copyWith(color: context.exInversePrimaryColor),
                    ),

                    15.h.verticalSpace,
                  ],
                ),
                Center(
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ).exBox(height: 40, width: 20)
              ],
            ),
            Divider(
              height: 10.h,
              color: context.exBackground,
            )
          ],
        ),
      ).onTap(() {
        if (controller.courses[widget.index].is_public == 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController codeController = TextEditingController();
              return AlertDialog(
                title: Text('ادخل الكود : ',
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                content: TextField(
                  controller: codeController,
                  decoration: InputDecoration(
                    label: Text("عذراً لايمكنك فتح هذا المحتوى حتى إدخال الكود"),
                    hintText: "أدخل الكود هنا",
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('إرسال'),
                    onPressed: () {
                      if (codeController.text == "your_code") {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CoursesQuestionsView(
                            id_course_bank_lesson_unite: controller.courses[widget.index].id,
                            type: "دورة",
                          ),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('الكود غير صحيح.')),
                        );
                      }
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
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CoursesQuestionsView(
              id_course_bank_lesson_unite: controller.courses[widget.index].id,
              type: "دورة",
            ),
          ));
        }
      }),
    );
  }
}
