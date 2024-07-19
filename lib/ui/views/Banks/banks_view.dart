import 'package:auto/core/resource/assets.dart';
import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/core/utils/extension/widget_extensions.dart';
import 'package:auto/ui/shared/custom_widgets/custom_text.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/views/Banks/widgets/banks_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/data/models/local_json/all_models.dart';
import '../../shared/colors.dart';
import 'banks_controller.dart';

class Banks extends StatefulWidget {
  Subject subject;

  Banks({super.key, required this.subject});

  @override
  State<Banks> createState() => _BanksState();
}

class _BanksState extends State<Banks> {
  FocusNode focusNode = FocusNode();

  ValueNotifier<bool> openTextField = ValueNotifier(false);

  TextEditingController searchController = TextEditingController();
  late BanksController controller;

  @override
  void initState() {
    controller = Get.put(BanksController());
    controller.readfile(widget.subject.subject_id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          backGroundColor: context.exOnPrimaryContainer,
          onTap: () => Navigator.of(context).pop(),
          titleText: ' بنوك مادة ${widget.subject.name}',
          titleTextStyle: context.exTextTheme.titleLarge!.copyWith(
              color: context.exOnBackground)),
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
                    controller: searchController,
                    onChanged:(query){
                      controller.filterBanks(query);
                    },
                    onTap: () => openTextField.value = true,
                    onTapOutside: (event) {
                      focusNode.unfocus();
                      if (identical(searchController.text, ''))
                        openTextField.value = false;
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
                                    )
                                  ]),
                        border: InputBorder.none))),
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
                    itemBuilder: (context, index) => BanksCardWidget(
                      subjectName: widget.subject.name,
                          index: index,
                        ),
                    itemCount: controller.filteredBanks.length)))
      ]),
    );
  }
}
