import 'package:auto/core/utils/extension/context_extensions.dart';
import 'package:auto/ui/shared/colors.dart';
import 'package:auto/ui/shared/custom_widgets/custom_text.dart';
import 'package:auto/ui/shared/main_app_bar.dart';
import 'package:auto/ui/shared/utils.dart';
import 'package:auto/ui/views/notification_screen/notification_screen.dart';
import 'package:auto/ui/views/subjects_screen/subject_view.dart';
import 'package:auto/ui/views/subscription_screen/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  late SubscriptionController controller;

  @override
  void initState() {
    controller = Get.put(SubscriptionController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        showArrowBack: false,
        onTap: () => Get.back(),
        titleTextStyle: TextStyle(
//
//
            color: Theme.of(context).colorScheme.primary,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Alexandria'),
        titleText: 'اتمتة',

        // textStyle: const TextStyle(color: Colors.black)
      ),
      drawer: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 50),
        child: Drawer(
          width: screenWidth(1.5),
          backgroundColor: AppColors.mainBlackColor.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
            child: ListView(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(screenWidth(10)),
                  splashColor: AppColors.blueB4,
                  onTap: () {
                    Get.to(NotificationScreen());
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: AppColors.mainWhiteColor,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CustomText(
                        textType: TextStyleType.custom,
                        text: "الاشعارات",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(screenWidth(10)),
                  splashColor: AppColors.blueB4,
                  onTap: () {
                    Get.changeThemeMode(
                        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: AppColors.mainWhiteColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CustomText(
                        textType: TextStyleType.custom,
                        text: Get.isDarkMode ? "الوضع المظلم" : "وضع الضوء",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // const SliverAppBar(
          //   centerTitle: true,
          //   pinned: true,
          //   title: CustomText(
          //     textType: TextStyleType.custom,
          //     text: "Auto(اتمتة)",
          //     textColor: AppColors.blueB4,
          //   ),
          // ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.all(20),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: 4,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => const SubjectView());
                  },
                  child: Container(

                    width: double.infinity,
                    height: screenHeight(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.exPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const CustomText(
                      textType: TextStyleType.custom,
                      text: "سبر ترشيحي علمي",
                    ),
                  ),
                ).animate().scale(delay: 300.ms);
              },
            ),
          ),
        ],
      ),
    );
  }
}
