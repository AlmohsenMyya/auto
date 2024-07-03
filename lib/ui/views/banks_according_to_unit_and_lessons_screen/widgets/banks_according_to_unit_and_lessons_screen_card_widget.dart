import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/views/UnitsByPart/units_screen_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../parts_questions_screen/parts_questions_view.dart';
import '../bank_according_to_unit_and_lessons_screen_controller.dart';

class BankAccordingToUnitAndLessonsScreenCardWidget extends StatefulWidget {
  final int index;

  BankAccordingToUnitAndLessonsScreenCardWidget({super.key, required this.index});

  @override
  State<BankAccordingToUnitAndLessonsScreenCardWidget> createState() => _CoursesAccordingToUnitAndLessonsScreenCardWidgetState();
}

class _CoursesAccordingToUnitAndLessonsScreenCardWidgetState extends State<BankAccordingToUnitAndLessonsScreenCardWidget> {
  late BankAccordingToUnitAndLessonsScreenController controller;

  @override
  void initState() {
    controller = Get.put(BankAccordingToUnitAndLessonsScreenController());
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
                      controller.parts[widget.index].name,
                      textDirection: TextDirection.ltr,
                      style: context.exTextTheme.titleMedium!
                          .copyWith(color: context.exPrimaryColor),
                    ),
                    15.h.verticalSpace,
                  ],
                ),
                Spacer(),
                InkWell(
                  child: Text(
                    "عرض الوحدات ",
                    textDirection: TextDirection.ltr,
                    style: context.exTextTheme.titleMedium!
                        .copyWith(color: context.exInversePrimaryColor, fontSize: 15.sp),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UnitsScreen(
                        part: controller.parts[widget.index],
                      ),
                    ));
                  },
                ),
                SizedBox(width: 15),
                InkWell(
                  child: Text(
                    "عرض الأسئلة ",
                    textDirection: TextDirection.ltr,
                    style: context.exTextTheme.titleMedium!
                        .copyWith(color: context.exInversePrimaryColor, fontSize: 15.sp),
                  ),
                  onTap: () {
                    // تحقق من is_public قبل السماح بالدخول
                    if (controller.questions[widget.index].isPublic == 0) {
                      // عرض مربع الحوار
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController codeController = TextEditingController();
                          return AlertDialog(
                            title: Text('ادخل الكود : ', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                            content: TextField(
                              controller: codeController,
                              decoration: InputDecoration(
                                  labelText: "عذراً لايمكنك فتح هذا المحتوى حتى إدخال الكود",
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
                                      builder: (context) => PartsQuestionsView(
                                        idPart: controller.parts[widget.index].id,
                                        type: '',
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
                        builder: (context) => PartsQuestionsView(
                          idPart: controller.parts[widget.index].id,
                          type: '',
                        ),
                      ));
                    }
                  },
                ),
                15.h.verticalSpace,
              ],
            ),
            Divider(
              height: 10.h,
              color: context.exBackground,
            )
          ],
        ),
      ),
    );
  }
}
