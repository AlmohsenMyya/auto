import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../banks_controller.dart';

class BanksCardWidget extends StatefulWidget {
  int index;

  BanksCardWidget({super.key, required this.index});

  @override
  State<BanksCardWidget> createState() => _BanksCardWidgetState();
}

class _BanksCardWidgetState extends State<BanksCardWidget> {
  late BanksController controller;

  @override
  void initState() {
    controller = Get.put(BanksController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
                      controller.banks[widget.index].name,
                      textDirection: TextDirection.ltr,
                      style: context.exTextTheme.titleMedium!
                          .copyWith(color:  context.exInversePrimaryColor),
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
      ).onTap((){
        // تحقق من is_public قبل السماح بالدخول
        if (controller.banks[widget.index].isPublic == 0) {
          // عرض مربع الحوار
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController codeController = TextEditingController();
              return AlertDialog(
                title: Text('ادخل الكود : ',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),

                content: TextField(
                  controller: codeController,
                  decoration: InputDecoration(label: Text(" عذراً لايمكنك فتح هذا المحتوى حتى إدخال الكود"),
                      hintText: "أدخل الكود هنا"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('إرسال'),
                    onPressed: () {
                      // التحقق من الكود المدخل
                      if (codeController.text == "your_code") {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CoursesQuestionsView(
                            id_course_bank_lesson_unite: controller.banks[widget.index].id,
                            type: "دورة",
                          ),
                        ));
                      } else {
                        // عرض رسالة خطأ إذا كان الكود غير صحيح
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
          // السماح بالدخول مباشرةً إذا كان is_public ليس 0
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CoursesQuestionsView(
            id_course_bank_lesson_unite: controller.banks[widget.index].id,
            type: "بنك",
            ),
          ));
        }
      }),
    );
  }
}

