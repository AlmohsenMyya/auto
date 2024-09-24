import 'package:auto2/core/resource/assets.dart';
import 'package:auto2/core/utils/extension/context_extensions.dart';
import 'package:auto2/core/utils/extension/widget_extensions.dart';
import 'package:auto2/ui/shared/custom_widgets/custom_text.dart';
import 'package:auto2/ui/shared/main_app_bar.dart';
import 'package:auto2/ui/views/UnitsByPart/units_screen_controller.dart';
import 'package:auto2/ui/views/courses_according_to_unit_and_lessons_screen/widgets/courses_according_to_unit_and_lessons_screen_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../shared/colors.dart';
import '../UnitsByPart/units_screen_view.dart';
import '../UnitsByPart/widgets/units_screen_card_widget.dart';
import '../courses/widgets/cources_card_widget.dart';
import 'courses_according_to_unit_and_lessons_screen_controller.dart';

class CoursesAccordingToUnitAndLessonsScreen extends StatefulWidget {
  Subject subject;
  Branch branch;

  CoursesAccordingToUnitAndLessonsScreen(
      {super.key, required this.branch, required this.subject});

  @override
  State<CoursesAccordingToUnitAndLessonsScreen> createState() =>
      _CoursesAccordingToUnitAndLessonsScreenState();
}

class _CoursesAccordingToUnitAndLessonsScreenState
    extends State<CoursesAccordingToUnitAndLessonsScreen> {
  FocusNode focusNode = FocusNode();
  ValueNotifier<bool> openTextField = ValueNotifier(false);
  TextEditingController searchController = TextEditingController();
  late CoursesAccordingToUnitAndLessonsScreenController controller;
  late UnitsScreenController unitController;

  @override
  void initState() {
    controller = Get.put(CoursesAccordingToUnitAndLessonsScreenController());
    unitController = Get.put(UnitsScreenController());
    unitController.readfileBySubject(widget.subject.subject_id!);
    controller.readfile(widget.subject.subject_id!);
    print("111");
    super.initState();

    // Start the showcase when the widget is built
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ShowCaseWidget.of(context).startShowCase([_searchKey]);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
            backGroundColor: context.exOnPrimaryContainer,
            onTap: () => Navigator.of(context).pop(),
            titleText: ' دورات مادة ${widget.subject.name}',
            titleTextStyle: context.exTextTheme.titleLarge!.copyWith(
              color: context.exOnBackground,
            )),
        body: Column(children: [
          //todo search

          10.h.verticalSpace,
          Container(
            width: 0.85.sw,
            height: 50.h,
            decoration: BoxDecoration(
                color: context.exOnPrimaryContainer,
                borderRadius: BorderRadius.circular(12.w)),
            child: ValueListenableBuilder(
              valueListenable: openTextField,
              builder: (context, value, child) => Align(
                alignment: Alignment.topRight,
                child: TextField(
                  onChanged: (query) {
                    if (controller.parts.isEmpty) {
                      unitController.filterunits(query);
                    } else {
                      controller.filterparts(query);
                    }
                  },
                  controller: searchController,
                  onTap: () => openTextField.value = true,
                  onTapOutside: (event) {
                    focusNode.unfocus();
                    if (identical(searchController.text, '')) {
                      openTextField.value = false;
                    }
                  },
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    label: value
                        ? const SizedBox.shrink()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              10.horizontalSpace,
                              SvgPicture.string(Asset.searchSvgIcon),
                              10.horizontalSpace,
                              CustomText(
                                textType: TextStyleType.body,
                                text: 'ابحث هنا',
                                textColor: context.exPrimaryContainer,
                              ),
                            ],
                          ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          20.h.verticalSpace,
          Obx(() => controller.isLoading.value
              ? SpinKitThreeBounce(
                  color: AppColors.blueB4,
                  size: 50.0,
                )
              : controller.parts.isEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => UnitsScreenCardWidget(
                          branch: widget.branch,
                          type_isCourse: "دورة",
                          index: index,
                          subjectName: widget.subject.name,
                        ),
                        itemCount: unitController.filteredunits.length,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            CoursesAccordingToUnitAndLessonsScreenCardWidget(
                          branch: widget.branch,
                          subjectName: widget.subject.name,
                          index: index,
                        ),
                        itemCount: controller.filteredparts.length,
                      ),
                    )),
        ]));
  }
}
