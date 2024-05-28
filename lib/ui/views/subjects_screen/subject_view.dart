import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/subjects_screen/Subject_controller.dart';
import 'package:auto/ui/views/subjects_screen/subject_widget/subject_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../shared/colors.dart';

class SubjectView extends StatefulWidget {
  int branch_id;

  SubjectView({super.key, required this.branch_id});

  @override
  State<SubjectView> createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  late SubjectController controller;

  @override
  void initState() {
    controller = Get.put(SubjectController());
    print("widget.branch_id ${widget.branch_id}");
    controller.readfile(widget.branch_id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          backGroundColor: context.exOnPrimaryContainer,
          showArrowBack: true,
          onTap: () => Get.back(),
          titleText: 'المواد الدراسية',
          titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Alexandria'))
      // textStyle: const TextStyle(color: Colors.black)

      ,
      body: Column(children: [
        SizedBox(
          height: 10.h,
        ),
        Obx(() => controller.isLoading.value
            ? SpinKitThreeBounce(
                color: AppColors.blueB4,
                size: 50.0,
              )
            : Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return SubjectTile(
                        subject: controller.subjects[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemCount: controller.subjects.length)))
      ]),
    );
  }
}
