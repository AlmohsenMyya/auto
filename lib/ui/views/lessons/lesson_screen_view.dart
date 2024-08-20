import 'package:auto/core/resource/assets.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';

import 'package:auto/ui/shared/custom_widgets/custom_text.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/UnitsByPart/widgets/units_screen_card_widget.dart';

import 'package:auto/ui/views/lessons/widgets/lesson_screen_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';

import '../../shared/colors.dart';
import 'lesson_screen_controller.dart';

class LessonScreen extends StatefulWidget {
  final Unit unit;
  final String subjectName;
  final String type_isCourse;
  Branch branch;
  LessonScreen({super.key, required this.unit ,required this.branch, required this.subjectName , required this.type_isCourse});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final GlobalKey _searchKey = GlobalKey();
  FocusNode focusNode = FocusNode();
  ValueNotifier<bool> openTextField = ValueNotifier(false);
  TextEditingController searchController = TextEditingController();
  late LessonScreenController controller;

  @override
  void initState() {
    controller = Get.put(LessonScreenController());
    print("lesssson number for this unit");
    print("nnnnnnnnnnnnn");
    controller.readLesson(widget.unit.id);
    print("Reading file for part ID: ${widget.unit.id}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        backGroundColor: context.exOnPrimaryContainer,
        onTap: () => Navigator.of(context).pop(),
        titleText: 'دروس  ${widget.unit.name}',
        titleTextStyle: context.exTextTheme.titleMedium!.copyWith(
            color: context.exOnBackground,
            fontFamily: 'Alexandria'
        ),
      ),
      body: Column(children: [
        10.h.verticalSpace,
        Container(
          width: 0.85.sw,
          height: 50.h,
          decoration: BoxDecoration(
              color: context.exOnPrimaryContainer,
              borderRadius: BorderRadius.circular(12.w)
          ),
          child: ValueListenableBuilder(
            valueListenable: openTextField,
            builder: (context, value, child) => Align(
              alignment: Alignment.topRight,
              child: TextField(
                onChanged: (query){
                  controller.filterlessons(query);
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
            : Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => LessonScreenCardWidget(
              branch: widget.branch,
              type_isCourse: widget.type_isCourse,
              subjectName: widget.subjectName ,
              index: index,
            ),
            itemCount: controller.filteredlessons.length,  // تعديل هنا
          ),
        ),
        ),
      ]),
    );
  }
}
