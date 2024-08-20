import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/views/courses_questions_screen/courses_questions_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/models/local_json/all_models.dart';
import '../../../shared/please_subscrib_botton.dart';
import '../../login_screen/login_view.dart';
import '../banks_controller.dart';

class BanksCardWidget extends StatefulWidget {
  int index;
  final String subjectName;
  Branch branch;
  BanksCardWidget({super.key, required this.index ,required this.branch, required this.subjectName});

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
                      controller.filteredBanks[widget.index].name,
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
              color: context.primaryColor,
            )
          ],
        ),
      ).onTap(()async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = await prefs.getString('access_token');
        // تحقق من is_public قبل السماح بالدخول

          bool isInMyBranch = await SubscriptionDialog.isMyBranch(
              widget.branch.branchId.toString());
          // تحقق من is_public قبل السماح بالدخول
          if (controller.filteredBanks[widget.index].isPublic == 0 && (token == null || !isInMyBranch)) {
            // عرض رسالة بسيطة وزر- الاشتراك
            SubscriptionDialog.showSubscriptionDialog(context);
          }  else {
          // السماح بالدخول مباشرةً إذا كان is_public ليس 0
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CoursesQuestionsView(
              subjectName: widget.subjectName,
            coursName: controller.filteredBanks[widget.index].name,
            id_course_bank_lesson_unite: controller.filteredBanks[widget.index].id,
            type: "بنك",
            ),
          ));
        }
      }),
    );
  }
}

